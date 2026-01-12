import 'package:equatable/equatable.dart';

/// Application status enum
enum ApplicationStatus {
  applied('Applied'),
  response('Response'),
  phoneScreen('Phone Screen'),
  technical('Technical'),
  final_('Final'),
  offer('Offer'),
  rejected('Rejected');

  final String displayName;
  const ApplicationStatus(this.displayName);

  static ApplicationStatus fromString(String value) {
    return ApplicationStatus.values.firstWhere(
      (status) => status.displayName == value,
      orElse: () => ApplicationStatus.applied,
    );
  }
}

/// Job Application Entity (Business Model)
/// Contains all 19 fields from Google Sheets + sync metadata
///
/// Reference: server/src/services/googleSheets.js:40-61
class ApplicationEntity extends Equatable {
  // Core Fields
  final String id; // Client-side UUID
  final int? sheetRowId; // Google Sheets row number (2+)
  final DateTime dateApplied;
  final String company;
  final String roleTitle;
  final ApplicationStatus status;

  // Application Details
  final String source; // LinkedIn, Indeed, Referral, Company Site, Recruiter
  final String applicationMethod; // Quick Apply, Full Application, Email
  final String location; // Remote, city, etc.
  final String companySize; // Startup <100, Mid 100-1000, Enterprise 1000+
  final String roleType; // Type of role
  final String techStack; // Technologies

  // Compensation
  final int? salaryMin;
  final int? salaryMax;

  // Metadata
  final bool customized; // Custom cover letter
  final bool referral; // Had referral
  final int? confidenceMatch; // 1-5 scale

  // Response Tracking
  final DateTime? responseDate;
  final String? responseType; // Email, Phone, Rejection, No Response
  final DateTime? interviewDate;

  // Additional
  final String notes;

  // Sync Fields
  final bool isDirty; // Needs sync to server
  final DateTime lastModified; // Last local change
  final DateTime? lastSynced; // Last successful sync

  const ApplicationEntity({
    required this.id,
    this.sheetRowId,
    required this.dateApplied,
    required this.company,
    required this.roleTitle,
    required this.status,
    required this.source,
    required this.applicationMethod,
    required this.location,
    required this.companySize,
    required this.roleType,
    required this.techStack,
    this.salaryMin,
    this.salaryMax,
    required this.customized,
    required this.referral,
    this.confidenceMatch,
    this.responseDate,
    this.responseType,
    this.interviewDate,
    required this.notes,
    this.isDirty = false,
    required this.lastModified,
    this.lastSynced,
  });

  /// Create a copy with updated fields
  ApplicationEntity copyWith({
    String? id,
    int? sheetRowId,
    DateTime? dateApplied,
    String? company,
    String? roleTitle,
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
    bool? isDirty,
    DateTime? lastModified,
    DateTime? lastSynced,
  }) {
    return ApplicationEntity(
      id: id ?? this.id,
      sheetRowId: sheetRowId ?? this.sheetRowId,
      dateApplied: dateApplied ?? this.dateApplied,
      company: company ?? this.company,
      roleTitle: roleTitle ?? this.roleTitle,
      status: status ?? this.status,
      source: source ?? this.source,
      applicationMethod: applicationMethod ?? this.applicationMethod,
      location: location ?? this.location,
      companySize: companySize ?? this.companySize,
      roleType: roleType ?? this.roleType,
      techStack: techStack ?? this.techStack,
      salaryMin: salaryMin ?? this.salaryMin,
      salaryMax: salaryMax ?? this.salaryMax,
      customized: customized ?? this.customized,
      referral: referral ?? this.referral,
      confidenceMatch: confidenceMatch ?? this.confidenceMatch,
      responseDate: responseDate ?? this.responseDate,
      responseType: responseType ?? this.responseType,
      interviewDate: interviewDate ?? this.interviewDate,
      notes: notes ?? this.notes,
      isDirty: isDirty ?? this.isDirty,
      lastModified: lastModified ?? this.lastModified,
      lastSynced: lastSynced ?? this.lastSynced,
    );
  }

  /// Check if this application is in the active pipeline
  /// Reference: client/src/utils/analytics.js:39
  bool get isActive {
    return [
      ApplicationStatus.applied,
      ApplicationStatus.response,
      ApplicationStatus.phoneScreen,
      ApplicationStatus.technical,
      ApplicationStatus.final_,
    ].contains(status);
  }

  /// Calculate days since application
  int get daysSinceApplied {
    final now = DateTime.now();
    final applicationDate = DateTime(
      dateApplied.year,
      dateApplied.month,
      dateApplied.day,
    );
    final today = DateTime(now.year, now.month, now.day);
    return today.difference(applicationDate).inDays;
  }

  /// Calculate days to response (if responded)
  int? get daysToResponse {
    if (responseDate == null) return null;

    final appliedDate = DateTime(
      dateApplied.year,
      dateApplied.month,
      dateApplied.day,
    );
    final responseDateOnly = DateTime(
      responseDate!.year,
      responseDate!.month,
      responseDate!.day,
    );

    return responseDateOnly.difference(appliedDate).inDays;
  }

  @override
  List<Object?> get props => [
        id,
        sheetRowId,
        dateApplied,
        company,
        roleTitle,
        status,
        source,
        applicationMethod,
        location,
        companySize,
        roleType,
        techStack,
        salaryMin,
        salaryMax,
        customized,
        referral,
        confidenceMatch,
        responseDate,
        responseType,
        interviewDate,
        notes,
        isDirty,
        lastModified,
        lastSynced,
      ];
}
