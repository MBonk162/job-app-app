import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/application_repository.dart';
import '../datasources/local/database_provider.dart';
import 'application_repository_impl.dart';

/// Provider for ApplicationRepository
final applicationRepositoryProvider = Provider<ApplicationRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ApplicationRepositoryImpl(database);
});
