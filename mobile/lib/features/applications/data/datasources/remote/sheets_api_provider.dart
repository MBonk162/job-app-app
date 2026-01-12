import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../auth/data/datasources/google_auth_datasource.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import 'sheets_api_datasource.dart';

/// Provider for Google Sheets API data source
/// Returns null if user is not authenticated
final sheetsApiDataSourceProvider = Provider<SheetsApiDataSource?>((ref) {
  final authDataSource = ref.watch(googleAuthDataSourceProvider);
  final currentUser = ref.watch(currentUserProvider);

  // Only create SheetsApiDataSource if user is signed in
  if (currentUser == null) {
    return null;
  }

  return SheetsApiDataSource(authDataSource);
});

/// Helper to check if remote sync is available
final isSyncAvailableProvider = Provider<bool>((ref) {
  final currentUser = ref.watch(currentUserProvider);
  return currentUser != null;
});
