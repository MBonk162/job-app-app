import '../../domain/entities/application_entity.dart';
import '../../domain/repositories/application_repository.dart';
import '../datasources/local/database.dart';
import '../models/application_model.dart';

/// Implementation of ApplicationRepository using local database
/// This is the offline-first implementation that stores data in SQLite
class ApplicationRepositoryImpl implements ApplicationRepository {
  final AppDatabase _database;

  ApplicationRepositoryImpl(this._database);

  @override
  Future<List<ApplicationEntity>> getAll() async {
    final applications = await _database.getAllApplications();
    return applications.map((app) => app.toEntity()).toList();
  }

  @override
  Future<ApplicationEntity?> getById(String id) async {
    final application = await _database.getApplicationById(id);
    return application?.toEntity();
  }

  @override
  Future<ApplicationEntity> create(ApplicationEntity application) async {
    // Mark as dirty since it needs to be synced
    final appToCreate = application.copyWith(
      isDirty: true,
      lastModified: DateTime.now(),
    );

    await _database.insertApplication(appToCreate.toCompanion());

    // Return the created application
    final created = await _database.getApplicationById(application.id);
    return created!.toEntity();
  }

  @override
  Future<ApplicationEntity> update(ApplicationEntity application) async {
    // Mark as dirty since it needs to be synced
    final appToUpdate = application.copyWith(
      isDirty: true,
      lastModified: DateTime.now(),
    );

    await _database.updateApplication(appToUpdate.toApplication());

    // Return the updated application
    final updated = await _database.getApplicationById(application.id);
    return updated!.toEntity();
  }

  @override
  Future<void> delete(String id) async {
    await _database.deleteApplication(id);
  }

  @override
  Stream<List<ApplicationEntity>> watchAll() {
    return _database.watchApplicationsSorted().map(
      (applications) => applications.map((app) => app.toEntity()).toList(),
    );
  }

  @override
  Stream<ApplicationEntity?> watchById(String id) {
    return _database.watchApplicationById(id).map(
      (application) => application?.toEntity(),
    );
  }

  @override
  Stream<List<ApplicationEntity>> search(String query) {
    return _database.searchApplications(query).map(
      (applications) => applications.map((app) => app.toEntity()).toList(),
    );
  }

  @override
  Stream<List<ApplicationEntity>> filterByStatus(String status) {
    return _database.filterByStatus(status).map(
      (applications) => applications.map((app) => app.toEntity()).toList(),
    );
  }

  @override
  Future<List<ApplicationEntity>> getDirty() async {
    final applications = await _database.getDirtyApplications();
    return applications.map((app) => app.toEntity()).toList();
  }

  @override
  Future<void> markAsSynced(String id) async {
    await _database.markAsSynced(id);
  }
}
