import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Network connectivity information
/// Used to determine online/offline state for sync operations
abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  final InternetConnection internetConnection;

  NetworkInfoImpl({
    required this.connectivity,
    required this.internetConnection,
  });

  @override
  Future<bool> get isConnected async {
    // First check if device has network connection
    final connectivityResults = await connectivity.checkConnectivity();
    final hasConnection = !connectivityResults.contains(ConnectivityResult.none);

    if (!hasConnection) return false;

    // Double-check with actual internet connection
    try {
      return await internetConnection.hasInternetAccess;
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return connectivity.onConnectivityChanged.asyncMap((results) async {
      final hasConnection = !results.contains(ConnectivityResult.none);

      if (!hasConnection) return false;

      try {
        return await internetConnection.hasInternetAccess;
      } catch (e) {
        return false;
      }
    });
  }
}
