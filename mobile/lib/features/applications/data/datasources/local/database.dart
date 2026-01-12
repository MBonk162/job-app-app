import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

/// Applications table schema
/// Matches the 19 fields from Google Sheets + sync metadata
/// Reference: server/src/services/googleSheets.js:40-61
class Applications extends Table {
  // Primary key (client-side UUID)
  TextColumn get id => text()();

  // Google Sheets row number (null if not yet synced)
  IntColumn get sheetRowId => integer().nullable()();

  // Core Fields (matching Google Sheets columns A-S)
  TextColumn get dateApplied => text()(); // Column A
  TextColumn get company => text()(); // Column B
  TextColumn get roleTitle => text()(); // Column C
  TextColumn get status => text()(); // Column R

  // Application Details
  TextColumn get source => text()(); // Column D
  TextColumn get applicationMethod => text()(); // Column E
  TextColumn get location => text()(); // Column H
  TextColumn get companySize => text()(); // Column I
  TextColumn get roleType => text()(); // Column J
  TextColumn get techStack => text()(); // Column K

  // Compensation
  IntColumn get salaryMin => integer().nullable()(); // Column F
  IntColumn get salaryMax => integer().nullable()(); // Column G

  // Metadata
  TextColumn get customized => text()(); // Column L (Yes/No)
  TextColumn get referral => text()(); // Column M (Yes/No)
  IntColumn get confidenceMatch => integer().nullable()(); // Column N (1-5)

  // Response Tracking
  TextColumn get responseDate => text().nullable()(); // Column O
  TextColumn get responseType => text().nullable()(); // Column P
  TextColumn get interviewDate => text().nullable()(); // Column Q

  // Additional
  TextColumn get notes => text()(); // Column S

  // Sync Metadata (not in Google Sheets)
  BoolColumn get isDirty => boolean().withDefault(const Constant(false))();
  TextColumn get lastModified => text()(); // Store as ISO8601 string
  TextColumn get lastSynced => text().nullable()(); // Store as ISO8601 string

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Applications])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Open database connection
  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'job_tracker.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }

  // CRUD Operations

  /// Get all applications
  Future<List<Application>> getAllApplications() async {
    return await select(applications).get();
  }

  /// Get application by ID
  Future<Application?> getApplicationById(String id) async {
    return await (select(applications)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  /// Get all dirty applications (need sync)
  Future<List<Application>> getDirtyApplications() async {
    return await (select(applications)..where((tbl) => tbl.isDirty.equals(true)))
        .get();
  }

  /// Insert new application
  Future<int> insertApplication(ApplicationsCompanion application) async {
    return await into(applications).insert(application);
  }

  /// Update application
  Future<bool> updateApplication(Application application) async {
    return await update(applications).replace(application);
  }

  /// Delete application by ID
  Future<int> deleteApplication(String id) async {
    return await (delete(applications)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Watch all applications (reactive stream)
  Stream<List<Application>> watchAllApplications() {
    return select(applications).watch();
  }

  /// Watch application by ID
  Stream<Application?> watchApplicationById(String id) {
    return (select(applications)..where((tbl) => tbl.id.equals(id)))
        .watchSingleOrNull();
  }

  /// Search applications by company or role title
  Stream<List<Application>> searchApplications(String query) {
    final lowerQuery = query.toLowerCase();
    return (select(applications)
          ..where((tbl) =>
              tbl.company.lower().like('%$lowerQuery%') |
              tbl.roleTitle.lower().like('%$lowerQuery%')))
        .watch();
  }

  /// Filter applications by status
  Stream<List<Application>> filterByStatus(String status) {
    return (select(applications)..where((tbl) => tbl.status.equals(status)))
        .watch();
  }

  /// Get applications sorted by date applied (descending)
  Stream<List<Application>> watchApplicationsSorted() {
    return (select(applications)
          ..orderBy([(t) => OrderingTerm.desc(t.dateApplied)]))
        .watch();
  }

  /// Mark application as dirty (needs sync)
  Future<void> markAsDirty(String id) async {
    await (update(applications)..where((tbl) => tbl.id.equals(id))).write(
      ApplicationsCompanion(
        isDirty: const Value(true),
        lastModified: Value(DateTime.now().toIso8601String()),
      ),
    );
  }

  /// Mark application as synced
  Future<void> markAsSynced(String id) async {
    await (update(applications)..where((tbl) => tbl.id.equals(id))).write(
      ApplicationsCompanion(
        isDirty: const Value(false),
        lastSynced: Value(DateTime.now().toIso8601String()),
      ),
    );
  }

  /// Delete all applications (for testing)
  Future<int> deleteAllApplications() async {
    return await delete(applications).go();
  }
}
