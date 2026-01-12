import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

/// Google Authentication Data Source
/// Handles Google Sign-In and provides authenticated API clients
class GoogleAuthDataSource {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      sheets.SheetsApi.spreadsheetsScope,
    ],
  );

  GoogleSignInAccount? _currentUser;

  /// Get current signed-in user
  GoogleSignInAccount? get currentUser => _currentUser;

  /// Check if user is signed in
  bool get isSignedIn => _currentUser != null;

  /// Initialize and check if already signed in
  Future<void> initialize() async {
    _currentUser = await _googleSignIn.signInSilently();
  }

  /// Sign in with Google
  Future<GoogleSignInAccount?> signIn() async {
    try {
      _currentUser = await _googleSignIn.signIn();
      return _currentUser;
    } catch (error) {
      print('Error signing in: $error');
      return null;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _currentUser = null;
  }

  /// Get authenticated Sheets API client
  Future<sheets.SheetsApi?> getSheetsApi() async {
    if (_currentUser == null) return null;

    try {
      // Use the extension method to get authenticated client
      final client = await _googleSignIn.authenticatedClient();
      if (client == null) return null;

      return sheets.SheetsApi(client);
    } catch (error) {
      print('Error getting Sheets API: $error');
      return null;
    }
  }

  /// Get authentication headers for manual API calls
  Future<Map<String, String>?> getAuthHeaders() async {
    if (_currentUser == null) return null;
    return await _currentUser!.authHeaders;
  }
}
