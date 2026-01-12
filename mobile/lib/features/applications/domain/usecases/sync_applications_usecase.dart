import 'package:drift/drift.dart';
import '../entities/application_entity.dart';
import '../../data/datasources/local/database.dart';
import '../../data/datasources/remote/sheets_api_datasource.dart';
import '../../data/models/application_model.dart';

/// Result of a sync operation
class SyncResult {
  final int downloaded;
  final int uploaded;
  final int conflicts;
  final List<String> errors;

  SyncResult({
    required this.downloaded,
    required this.uploaded,
    required this.conflicts,
    required this.errors,
  });

  bool get hasErrors => errors.isNotEmpty;
  bool get hasConflicts => conflicts > 0;

  @override
  String toString() {
    return 'SyncResult(downloaded: $downloaded, uploaded: $uploaded, conflicts: $conflicts, errors: ${errors.length})';
  }
}

/// Use case for syncing applications between local database and Google Sheets
class SyncApplicationsUseCase {
  final AppDatabase _database;
  final SheetsApiDataSource? _remoteDataSource;

  SyncApplicationsUseCase(this._database, this._remoteDataSource);

  /// Perform full sync: download from Sheets, then upload dirty local records
  Future<SyncResult> execute() async {
    // Check if remote sync is available
    if (_remoteDataSource == null) {
      return SyncResult(
        downloaded: 0,
        uploaded: 0,
        conflicts: 0,
        errors: ['Not authenticated. Cannot sync without sign-in.'],
      );
    }

    int downloaded = 0;
    int uploaded = 0;
    int conflicts = 0;
    final errors = <String>[];

    try {
      // Step 1: Fetch all applications from Google Sheets
      print('Fetching applications from Google Sheets...');
      final remoteApps = await _remoteDataSource.fetchAll();
      print('Fetched ${remoteApps.length} applications from Sheets');

      // Step 2: Get all local applications
      final localAppsDb = await _database.getAllApplications();
      final localApps = localAppsDb.map((app) => app.toEntity()).toList();
      print('Found ${localApps.length} applications in local database');

      // Create maps for easier lookup
      final localById = {for (var app in localApps) app.id: app};
      final localDbById = {for (var app in localAppsDb) app.id: app};

      // Step 3: Download phase - process remote applications
      for (final remoteApp in remoteApps) {
        try {
          final localApp = localById[remoteApp.id];

          if (localApp == null) {
            // New application from Sheets - insert locally
            final companion = remoteApp.toCompanion();
            await _database.insertApplication(companion);
            downloaded++;
            print('Downloaded new application: ${remoteApp.company}');
          } else {
            // Application exists locally - check if remote is newer
            final remoteModified = remoteApp.lastModified;
            final localModified = localApp.lastModified;

            if (localApp.isDirty && remoteModified.isAfter(localModified)) {
              // CONFLICT: Both local and remote have changes
              conflicts++;
              print('Conflict detected for: ${remoteApp.company}');
              // For now, keep local version (user will resolve later)
              // TODO: Implement conflict resolution UI
            } else if (remoteModified.isAfter(localModified)) {
              // Remote is newer - update local
              // Convert entity to database Application object
              final dbApp = localDbById[remoteApp.id];
              if (dbApp != null) {
                // Create updated Application from remoteApp
                final updatedDb = remoteApp.toCompanion().toApplication();
                await _database.updateApplication(updatedDb);
                downloaded++;
                print('Updated local application: ${remoteApp.company}');
              }
            }
          }
        } catch (e) {
          errors.add('Error processing remote app ${remoteApp.company}: $e');
          print('Error processing remote app: $e');
        }
      }

      // Step 4: Upload phase - upload dirty local applications
      final dirtyAppsDb = await _database.getDirtyApplications();
      final dirtyApps = dirtyAppsDb.map((app) => app.toEntity()).toList();
      print('Found ${dirtyApps.length} dirty applications to upload');

      for (var i = 0; i < dirtyApps.length; i++) {
        final dirtyApp = dirtyApps[i];
        final dirtyDbApp = dirtyAppsDb[i];

        try {
          if (dirtyApp.sheetRowId == null) {
            // New application - create in Sheets
            final updatedApp = await _remoteDataSource.create(dirtyApp);

            // Update local database with sheet row ID
            final updatedDb = updatedApp.toCompanion().toApplication();
            await _database.updateApplication(updatedDb);
            uploaded++;
            print('Uploaded new application: ${dirtyApp.company}');
          } else {
            // Existing application - update in Sheets
            // Check if remote was modified since our last sync
            final remoteApp = remoteApps.where((r) => r.sheetRowId == dirtyApp.sheetRowId).firstOrNull;

            if (remoteApp != null &&
                remoteApp.lastModified.isAfter(dirtyApp.lastSynced ?? DateTime(2000))) {
              // CONFLICT: Remote was modified after our last sync
              conflicts++;
              print('Conflict detected during upload: ${dirtyApp.company}');
              // For now, force upload local version
              // TODO: Implement conflict resolution UI
            }

            final updatedApp = await _remoteDataSource.update(dirtyApp);

            // Update local database to mark as synced
            final updatedDb = updatedApp.toCompanion().toApplication();
            await _database.updateApplication(updatedDb);
            uploaded++;
            print('Uploaded updated application: ${dirtyApp.company}');
          }
        } catch (e) {
          errors.add('Error uploading app ${dirtyApp.company}: $e');
          print('Error uploading app: $e');
        }
      }

      print('Sync complete: $downloaded downloaded, $uploaded uploaded, $conflicts conflicts');
    } catch (e) {
      errors.add('Sync failed: $e');
      print('Sync failed: $e');
    }

    return SyncResult(
      downloaded: downloaded,
      uploaded: uploaded,
      conflicts: conflicts,
      errors: errors,
    );
  }
}

// Extension to convert ApplicationsCompanion to Application
extension ApplicationsCompanionToApplication on ApplicationsCompanion {
  Application toApplication() {
    return Application(
      id: id.value,
      sheetRowId: sheetRowId.value,
      dateApplied: dateApplied.value,
      company: company.value,
      roleTitle: roleTitle.value,
      status: status.value,
      source: source.value,
      applicationMethod: applicationMethod.value,
      location: location.value,
      companySize: companySize.value,
      roleType: roleType.value,
      techStack: techStack.value,
      salaryMin: salaryMin.value,
      salaryMax: salaryMax.value,
      customized: customized.value,
      referral: referral.value,
      confidenceMatch: confidenceMatch.value,
      responseDate: responseDate.value,
      responseType: responseType.value,
      interviewDate: interviewDate.value,
      notes: notes.value,
      isDirty: isDirty.value,
      lastModified: lastModified.value,
      lastSynced: lastSynced.value,
    );
  }
}
