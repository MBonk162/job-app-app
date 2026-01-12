import '../entities/application_entity.dart';

/// Repository interface for job applications
/// Defines the contract for accessing application data (both local and remote)
abstract class ApplicationRepository {
  /// Get all applications
  Future<List<ApplicationEntity>> getAll();

  /// Get application by ID
  Future<ApplicationEntity?> getById(String id);

  /// Create new application
  Future<ApplicationEntity> create(ApplicationEntity application);

  /// Update existing application
  Future<ApplicationEntity> update(ApplicationEntity application);

  /// Delete application
  Future<void> delete(String id);

  /// Watch all applications (reactive stream)
  Stream<List<ApplicationEntity>> watchAll();

  /// Watch application by ID
  Stream<ApplicationEntity?> watchById(String id);

  /// Search applications by query
  Stream<List<ApplicationEntity>> search(String query);

  /// Filter by status
  Stream<List<ApplicationEntity>> filterByStatus(String status);

  /// Get dirty applications (need sync)
  Future<List<ApplicationEntity>> getDirty();

  /// Mark as synced
  Future<void> markAsSynced(String id);
}
