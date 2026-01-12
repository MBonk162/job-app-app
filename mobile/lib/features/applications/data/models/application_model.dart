import 'package:drift/drift.dart';
import '../../domain/entities/application_entity.dart';
import '../datasources/local/database.dart';
import 'package:uuid/uuid.dart';

/// Extension to convert between database Application and domain ApplicationEntity
extension ApplicationMapper on Application {
  /// Convert database Application to domain ApplicationEntity
  ApplicationEntity toEntity() {
    return ApplicationEntity(
      id: id,
      sheetRowId: sheetRowId,
      dateApplied: DateTime.parse(dateApplied),
      company: company,
      roleTitle: roleTitle,
      status: ApplicationStatus.fromString(status),
      source: source,
      applicationMethod: applicationMethod,
      location: location,
      companySize: companySize,
      roleType: roleType,
      techStack: techStack,
      salaryMin: salaryMin,
      salaryMax: salaryMax,
      customized: customized == 'Yes',
      referral: referral == 'Yes',
      confidenceMatch: confidenceMatch,
      responseDate: responseDate != null ? DateTime.parse(responseDate!) : null,
      responseType: responseType,
      interviewDate: interviewDate != null ? DateTime.parse(interviewDate!) : null,
      notes: notes,
      isDirty: isDirty,
      lastModified: DateTime.parse(lastModified),
      lastSynced: lastSynced != null ? DateTime.parse(lastSynced!) : null,
    );
  }
}

/// Extension to convert ApplicationEntity to database ApplicationsCompanion
extension ApplicationEntityMapper on ApplicationEntity {
  /// Convert domain ApplicationEntity to database ApplicationsCompanion for insert
  ApplicationsCompanion toCompanion() {
    return ApplicationsCompanion(
      id: Value(id),
      sheetRowId: Value(sheetRowId),
      dateApplied: Value(_formatDate(dateApplied)),
      company: Value(company),
      roleTitle: Value(roleTitle),
      status: Value(status.displayName),
      source: Value(source),
      applicationMethod: Value(applicationMethod),
      location: Value(location),
      companySize: Value(companySize),
      roleType: Value(roleType),
      techStack: Value(techStack),
      salaryMin: Value(salaryMin),
      salaryMax: Value(salaryMax),
      customized: Value(customized ? 'Yes' : 'No'),
      referral: Value(referral ? 'Yes' : 'No'),
      confidenceMatch: Value(confidenceMatch),
      responseDate: Value(responseDate != null ? _formatDate(responseDate!) : null),
      responseType: Value(responseType),
      interviewDate: Value(interviewDate != null ? _formatDate(interviewDate!) : null),
      notes: Value(notes),
      isDirty: Value(isDirty),
      lastModified: Value(lastModified.toIso8601String()),
      lastSynced: Value(lastSynced?.toIso8601String()),
    );
  }

  /// Convert to database Application object
  Application toApplication() {
    return Application(
      id: id,
      sheetRowId: sheetRowId,
      dateApplied: _formatDate(dateApplied),
      company: company,
      roleTitle: roleTitle,
      status: status.displayName,
      source: source,
      applicationMethod: applicationMethod,
      location: location,
      companySize: companySize,
      roleType: roleType,
      techStack: techStack,
      salaryMin: salaryMin,
      salaryMax: salaryMax,
      customized: customized ? 'Yes' : 'No',
      referral: referral ? 'Yes' : 'No',
      confidenceMatch: confidenceMatch,
      responseDate: responseDate != null ? _formatDate(responseDate!) : null,
      responseType: responseType,
      interviewDate: interviewDate != null ? _formatDate(interviewDate!) : null,
      notes: notes,
      isDirty: isDirty,
      lastModified: lastModified.toIso8601String(),
      lastSynced: lastSynced?.toIso8601String(),
    );
  }

  /// Format date as YYYY-MM-DD string
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

/// Helper to create a new ApplicationEntity with defaults
class ApplicationEntityFactory {
  static ApplicationEntity create({
    required String company,
    required String roleTitle,
    DateTime? dateApplied,
    ApplicationStatus? status,
    String? source,
    String? applicationMethod,
    String? location,
    String? companySize,
    String? roleType,
    String? techStack,
    int? salaryMin,
    int? salaryMax,
    bool? customized,
    bool? referral,
    int? confidenceMatch,
    DateTime? responseDate,
    String? responseType,
    DateTime? interviewDate,
    String? notes,
  }) {
    final now = DateTime.now();
    return ApplicationEntity(
      id: const Uuid().v4(),
      sheetRowId: null,
      dateApplied: dateApplied ?? DateTime(now.year, now.month, now.day),
      company: company,
      roleTitle: roleTitle,
      status: status ?? ApplicationStatus.applied,
      source: source ?? 'LinkedIn',
      applicationMethod: applicationMethod ?? 'Quick Apply',
      location: location ?? '',
      companySize: companySize ?? '',
      roleType: roleType ?? '',
      techStack: techStack ?? '',
      salaryMin: salaryMin,
      salaryMax: salaryMax,
      customized: customized ?? false,
      referral: referral ?? false,
      confidenceMatch: confidenceMatch ?? 3,
      responseDate: responseDate,
      responseType: responseType,
      interviewDate: interviewDate,
      notes: notes ?? '',
      isDirty: true, // New applications need sync
      lastModified: now,
      lastSynced: null,
    );
  }
}
