import 'package:googleapis/sheets/v4.dart' as sheets;
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/utils/date_utils.dart';
import '../../models/application_model.dart';
import '../../../domain/entities/application_entity.dart';
import '../../../../auth/data/datasources/google_auth_datasource.dart';

/// Google Sheets API Data Source
/// Handles all interactions with the Google Sheets backend
class SheetsApiDataSource {
  final GoogleAuthDataSource _authDataSource;

  SheetsApiDataSource(this._authDataSource);

  /// Get authenticated Sheets API client
  Future<sheets.SheetsApi> _getSheetsApi() async {
    final api = await _authDataSource.getSheetsApi();
    if (api == null) {
      throw Exception('Not authenticated. Please sign in first.');
    }
    return api;
  }

  /// Fetch all applications from Google Sheets
  /// Returns list of applications from Sheet1!A2:S (skipping header row)
  Future<List<ApplicationEntity>> fetchAll() async {
    try {
      final sheetsApi = await _getSheetsApi();
      final response = await sheetsApi.spreadsheets.values.get(
        AppConstants.spreadsheetId,
        AppConstants.sheetDataRange,
      );

      final rows = response.values;
      if (rows == null || rows.isEmpty) {
        return [];
      }

      final applications = <ApplicationEntity>[];

      // Start from row 2 (index 0 in response, but row 2 in sheet)
      for (var i = 0; i < rows.length; i++) {
        final row = rows[i];

        // Skip blank rows (empty company AND role_title)
        if (row.isEmpty || (row.length >= 2 &&
            (row[0] == null || row[0].toString().trim().isEmpty) &&
            (row[1] == null || row[1].toString().trim().isEmpty))) {
          continue;
        }

        try {
          final app = _rowToApplication(row, i + 2); // +2 because row 1 is header
          applications.add(app);
        } catch (e) {
          print('Error parsing row ${i + 2}: $e');
          // Skip malformed rows
        }
      }

      return applications;
    } catch (e) {
      print('Error fetching from Google Sheets: $e');
      rethrow;
    }
  }

  /// Create a new application in Google Sheets
  /// Appends a new row and returns the application with sheetRowId set
  Future<ApplicationEntity> create(ApplicationEntity application) async {
    try {
      final sheetsApi = await _getSheetsApi();
      final row = _applicationToRow(application);

      final valueRange = sheets.ValueRange(
        values: [row],
      );

      final response = await sheetsApi.spreadsheets.values.append(
        valueRange,
        AppConstants.spreadsheetId,
        AppConstants.sheetAppendRange,
        valueInputOption: 'USER_ENTERED',
        insertDataOption: 'INSERT_ROWS',
      );

      // Extract the row number from the response
      // Response format: "Sheet1!A123:S123"
      final updatedRange = response.updates?.updatedRange ?? '';
      final rowNumber = _extractRowNumber(updatedRange);

      return application.copyWith(
        sheetRowId: rowNumber,
        lastSynced: DateTime.now(),
        isDirty: false,
      );
    } catch (e) {
      print('Error creating application in Google Sheets: $e');
      rethrow;
    }
  }

  /// Update an existing application in Google Sheets
  Future<ApplicationEntity> update(ApplicationEntity application) async {
    if (application.sheetRowId == null) {
      throw ArgumentError('Cannot update application without sheetRowId');
    }

    try {
      final sheetsApi = await _getSheetsApi();
      final row = _applicationToRow(application);
      final range = 'Sheet1!A${application.sheetRowId}:S${application.sheetRowId}';

      final valueRange = sheets.ValueRange(
        values: [row],
      );

      await sheetsApi.spreadsheets.values.update(
        valueRange,
        AppConstants.spreadsheetId,
        range,
        valueInputOption: 'USER_ENTERED',
      );

      return application.copyWith(
        lastSynced: DateTime.now(),
        isDirty: false,
      );
    } catch (e) {
      print('Error updating application in Google Sheets: $e');
      rethrow;
    }
  }

  /// Delete an application from Google Sheets by row ID
  Future<void> delete(int sheetRowId) async {
    try {
      final sheetsApi = await _getSheetsApi();
      final request = sheets.Request(
        deleteDimension: sheets.DeleteDimensionRequest(
          range: sheets.DimensionRange(
            sheetId: 0, // Default first sheet
            dimension: 'ROWS',
            startIndex: sheetRowId - 1, // 0-indexed
            endIndex: sheetRowId,
          ),
        ),
      );

      final batchUpdateRequest = sheets.BatchUpdateSpreadsheetRequest(
        requests: [request],
      );

      await sheetsApi.spreadsheets.batchUpdate(
        batchUpdateRequest,
        AppConstants.spreadsheetId,
      );
    } catch (e) {
      print('Error deleting application from Google Sheets: $e');
      rethrow;
    }
  }

  /// Convert a sheet row to an ApplicationEntity
  /// Row format matches server/src/services/googleSheets.js:64-87
  ApplicationEntity _rowToApplication(List<dynamic> row, int rowNumber) {
    // Helper to safely get string value
    String getString(int index, [String defaultValue = '']) {
      if (index >= row.length) return defaultValue;
      final value = row[index];
      return value?.toString() ?? defaultValue;
    }

    // Helper to safely get int value
    int? getInt(int index) {
      if (index >= row.length) return null;
      final value = row[index];
      if (value == null || value.toString().trim().isEmpty) return null;
      return int.tryParse(value.toString());
    }

    // Helper to parse date string to DateTime
    DateTime? parseDate(int index) {
      final dateStr = getString(index);
      if (dateStr.isEmpty) return null;
      return AppDateUtils.parseLocalDate(dateStr);
    }

    // Helper to parse Yes/No to bool
    bool parseBool(int index, [bool defaultValue = false]) {
      final str = getString(index, defaultValue ? 'Yes' : 'No');
      return str.toLowerCase() == 'yes' || str == 'true';
    }

    return ApplicationEntity(
      id: getString(0), // Column A: id
      sheetRowId: rowNumber,
      dateApplied: parseDate(1) ?? DateTime.now(), // Column B: date_applied
      company: getString(2), // Column C: company
      roleTitle: getString(3), // Column D: role_title
      status: ApplicationStatus.fromString(getString(4, 'Applied')), // Column E: status
      source: getString(5, 'LinkedIn'), // Column F: source
      applicationMethod: getString(6, 'Quick Apply'), // Column G: application_method
      location: getString(7), // Column H: location
      companySize: getString(8), // Column I: company_size
      roleType: getString(9), // Column J: role_type
      techStack: getString(10), // Column K: tech_stack
      salaryMin: getInt(11), // Column L: salary_min
      salaryMax: getInt(12), // Column M: salary_max
      customized: parseBool(13, false), // Column N: customized
      referral: parseBool(14, false), // Column O: referral
      confidenceMatch: getInt(15), // Column P: confidence_match
      responseDate: parseDate(16), // Column Q: response_date
      responseType: getString(17), // Column R: response_type
      interviewDate: parseDate(18), // Column S: interview_date
      notes: '', // Notes are not stored in Sheets, only locally
      isDirty: false,
      lastModified: DateTime.now(),
      lastSynced: DateTime.now(),
    );
  }

  /// Convert an ApplicationEntity to a sheet row
  /// Row format matches server/src/services/googleSheets.js:90-111
  List<dynamic> _applicationToRow(ApplicationEntity application) {
    return [
      application.id, // Column A: id
      AppDateUtils.formatLocalDate(application.dateApplied), // Column B: date_applied
      application.company, // Column C: company
      application.roleTitle, // Column D: role_title
      application.status.displayName, // Column E: status
      application.source, // Column F: source
      application.applicationMethod, // Column G: application_method
      application.location, // Column H: location
      application.companySize, // Column I: company_size
      application.roleType, // Column J: role_type
      application.techStack, // Column K: tech_stack
      application.salaryMin ?? '', // Column L: salary_min
      application.salaryMax ?? '', // Column M: salary_max
      application.customized ? 'Yes' : 'No', // Column N: customized
      application.referral ? 'Yes' : 'No', // Column O: referral
      application.confidenceMatch ?? '', // Column P: confidence_match
      application.responseDate != null
          ? AppDateUtils.formatLocalDate(application.responseDate!)
          : '', // Column Q: response_date
      application.responseType ?? '', // Column R: response_type
      application.interviewDate != null
          ? AppDateUtils.formatLocalDate(application.interviewDate!)
          : '', // Column S: interview_date
      // Note: notes are not synced to Sheets, only stored locally
    ];
  }

  /// Extract row number from range string (e.g., "Sheet1!A5:S5" -> 5)
  int _extractRowNumber(String range) {
    final match = RegExp(r'!A(\d+):').firstMatch(range);
    if (match != null) {
      return int.parse(match.group(1)!);
    }
    throw FormatException('Could not extract row number from range: $range');
  }
}
