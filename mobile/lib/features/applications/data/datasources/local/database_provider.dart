import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database.dart';

/// Provider for the AppDatabase instance
/// This creates a single database instance for the entire app
final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();

  // Close database when provider is disposed
  ref.onDispose(() {
    database.close();
  });

  return database;
});
