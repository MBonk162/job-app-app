/// Application-wide constants
class AppConstants {
  // Google Sheets Configuration
  // Default sheet ID (can be overridden by user configuration)
  static const String defaultSpreadsheetId = '1SGzwZd5Sl8LtNAEdTOlvw-llIIgOSSZlykxlvRhQZaw';

  // Demo mode identifier
  static const String demoModeId = 'demo';

  // Current spreadsheet ID - can be dynamically set
  static String _currentSpreadsheetId = defaultSpreadsheetId;
  static bool _isDemoMode = true; // Default to demo mode for portfolio

  // Getters for current configuration
  static String get spreadsheetId => _isDemoMode ? demoModeId : _currentSpreadsheetId;
  static String get googleSpreadsheetId => spreadsheetId; // Alias for compatibility
  static bool get isDemoMode => _isDemoMode;

  // Setters for runtime configuration
  static void setSpreadsheetId(String id) {
    _currentSpreadsheetId = id;
    _isDemoMode = false;
  }

  static void enableDemoMode() {
    _isDemoMode = true;
  }

  static void disableDemoMode(String sheetId) {
    _currentSpreadsheetId = sheetId;
    _isDemoMode = false;
  }

  // Sheet structure constants
  static const String sheetName = 'Sheet1';
  static const String dataRange = 'A2:S'; // Skip header row
  static const String sheetDataRange = '$sheetName!$dataRange'; // Sheet1!A2:S
  static const String sheetAppendRange = '$sheetName!A:A'; // Sheet1!A:A (append to sheet)

  // Application Status Values (matching web app)
  static const List<String> applicationStatuses = [
    'Applied',
    'Response',
    'Phone Screen',
    'Technical',
    'Final',
    'Offer',
    'Rejected',
  ];

  // Active Pipeline Statuses (for analytics)
  static const List<String> activeStatuses = [
    'Applied',
    'Response',
    'Phone Screen',
    'Technical',
    'Final',
  ];

  // Application Sources
  static const List<String> sources = [
    'LinkedIn',
    'Indeed',
    'Referral',
    'Company Site',
    'Recruiter',
  ];

  // Application Methods
  static const List<String> applicationMethods = [
    'Quick Apply',
    'Full Application',
    'Email',
  ];

  // Company Sizes
  static const List<String> companySizes = [
    'Startup <100',
    'Mid 100-1000',
    'Enterprise 1000+',
  ];

  // Response Types
  static const List<String> responseTypes = [
    'Email',
    'Phone',
    'Rejection',
    'No Response',
  ];

  // Yes/No Options
  static const List<String> yesNoOptions = ['Yes', 'No'];

  // Default Values
  static const String defaultSource = 'LinkedIn';
  static const String defaultApplicationMethod = 'Quick Apply';
  static const int defaultConfidenceMatch = 3;

  // Sync Configuration
  static const Duration syncInterval = Duration(hours: 1);
  static const Duration syncTimeout = Duration(seconds: 30);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const int maxItemsPerPage = 50;
}
