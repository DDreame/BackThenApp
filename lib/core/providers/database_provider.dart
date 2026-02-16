import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';

/// Provider for shared database instance
final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();

  // Cleanup when provider is disposed
  ref.onDispose(() {
    database.close();
  });

  return database;
});
