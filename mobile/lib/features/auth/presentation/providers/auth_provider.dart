import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/datasources/google_auth_datasource.dart';

/// Provider for Google Auth Data Source
final googleAuthDataSourceProvider = Provider<GoogleAuthDataSource>((ref) {
  return GoogleAuthDataSource();
});

/// Provider for current user state
class CurrentUserNotifier extends Notifier<GoogleSignInAccount?> {
  late GoogleAuthDataSource _authDataSource;

  @override
  GoogleSignInAccount? build() {
    _authDataSource = ref.watch(googleAuthDataSourceProvider);
    _initialize();
    return null;
  }

  Future<void> _initialize() async {
    await _authDataSource.initialize();
    state = _authDataSource.currentUser;
  }

  Future<void> signIn() async {
    final user = await _authDataSource.signIn();
    state = user;
  }

  Future<void> signOut() async {
    await _authDataSource.signOut();
    state = null;
  }
}

final currentUserProvider = NotifierProvider<CurrentUserNotifier, GoogleSignInAccount?>(
  () => CurrentUserNotifier(),
);

/// Provider for offline mode bypass
final offlineModeProvider = NotifierProvider<OfflineModeNotifier, bool>(
  () => OfflineModeNotifier(),
);

class OfflineModeNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void enable() => state = true;
  void disable() => state = false;
}

/// Provider to check if user is signed in or in offline mode
final isSignedInProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  final offlineMode = ref.watch(offlineModeProvider);
  return user != null || offlineMode;
});
