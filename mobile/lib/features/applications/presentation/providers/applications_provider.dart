import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/database_provider.dart';
import '../../data/datasources/remote/sheets_api_provider.dart';
import '../../data/models/application_model.dart';
import '../../data/repositories/application_repository_provider.dart';
import '../../domain/entities/application_entity.dart';
import '../../domain/usecases/sync_applications_usecase.dart';

/// Provider that watches all applications from the database
final applicationsProvider = StreamProvider<List<ApplicationEntity>>((ref) {
  final repository = ref.watch(applicationRepositoryProvider);
  return repository.watchAll();
});

/// Provider to create a test application
final createTestApplicationProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final repository = ref.read(applicationRepositoryProvider);

    // Create a test application
    final testApp = ApplicationEntityFactory.create(
      company: 'Test Company ${DateTime.now().millisecond}',
      roleTitle: 'Flutter Developer',
      source: 'LinkedIn',
      location: 'Remote',
      techStack: 'Flutter, Dart, Firebase',
      salaryMin: 100000,
      salaryMax: 150000,
      customized: true,
      referral: false,
      confidenceMatch: 4,
      notes: 'Test application created from Flutter app',
    );

    await repository.create(testApp);
  };
});

/// Provider to delete all applications (for testing)
final deleteAllApplicationsProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final database = ref.read(applicationRepositoryProvider);
    final allApps = await database.getAll();

    for (final app in allApps) {
      await database.delete(app.id);
    }
  };
});

/// Provider for sync use case
final syncApplicationsUseCaseProvider = Provider<SyncApplicationsUseCase>((ref) {
  final database = ref.watch(databaseProvider);
  final remoteDataSource = ref.watch(sheetsApiDataSourceProvider);

  return SyncApplicationsUseCase(database, remoteDataSource);
});

/// Provider to trigger sync
final syncApplicationsProvider = Provider<Future<SyncResult> Function()>((ref) {
  return () async {
    final syncUseCase = ref.read(syncApplicationsUseCaseProvider);
    return await syncUseCase.execute();
  };
});

/// Provider to trigger clear and re-sync
/// Deletes all local data and re-downloads from Google Sheets
final clearAndResyncProvider = Provider<Future<SyncResult> Function()>((ref) {
  return () async {
    final syncUseCase = ref.read(syncApplicationsUseCaseProvider);
    return await syncUseCase.clearAndResync();
  };
});

/// Provider to track last sync time
class LastSyncTimeNotifier extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;

  void update(DateTime time) => state = time;
}

final lastSyncTimeProvider = NotifierProvider<LastSyncTimeNotifier, DateTime?>(
  () => LastSyncTimeNotifier(),
);

/// Provider to track sync status
enum SyncStatus { idle, syncing, success, error }

class SyncStatusNotifier extends Notifier<SyncStatus> {
  @override
  SyncStatus build() => SyncStatus.idle;

  void setStatus(SyncStatus status) => state = status;
}

final syncStatusProvider = NotifierProvider<SyncStatusNotifier, SyncStatus>(
  () => SyncStatusNotifier(),
);
