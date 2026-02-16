import 'package:drift/drift.dart';

import '../models/user.dart' as models;
import '../database/app_database.dart';

/// Repository for managing User entries in the database
class UserRepository {
  final AppDatabase _db;

  /// Default user ID (single user app)
  static const String defaultUserId = 'default_user';

  UserRepository(this._db);

  /// Convert Drift User data class to domain User model
  models.User _toModel(User data) {
    return models.User(
      id: data.id,
      username: data.username,
      avatar: data.avatar,
      streakDays: data.streakDays,
      totalFeelings: data.totalFeelings,
    );
  }

  /// Get the current user (assuming single user, return first or create default)
  Future<models.User?> getUser() async {
    final result = await (_db.select(_db.users)..limit(1)).getSingleOrNull();
    return result != null ? _toModel(result) : null;
  }

  /// Create default user if none exists
  Future<models.User> createDefaultUser() async {
    final existingUser = await getUser();
    if (existingUser != null) {
      return existingUser;
    }

    final id = defaultUserId;
    const username = '当时';

    final companion = UsersCompanion(
      id: Value(id),
      username: const Value(username),
      avatar: const Value(null),
      streakDays: const Value(0),
      totalFeelings: const Value(0),
    );

    await _db.into(_db.users).insert(companion);

    return models.User(
      id: id,
      username: username,
      avatar: null,
      streakDays: 0,
      totalFeelings: 0,
    );
  }

  /// Update streak days
  Future<void> updateStreak(int streakDays) async {
    await (_db.update(_db.users)..where((t) => t.id.equals(defaultUserId)))
        .write(UsersCompanion(streakDays: Value(streakDays)));
  }

  /// Increment total feelings count
  Future<void> incrementTotalFeelings() async {
    final user = await getUser();
    if (user != null) {
      await (_db.update(_db.users)..where((t) => t.id.equals(defaultUserId)))
          .write(UsersCompanion(totalFeelings: Value(user.totalFeelings + 1)));
    }
  }

  /// Update user avatar
  Future<void> updateAvatar(String? avatarPath) async {
    await (_db.update(_db.users)..where((t) => t.id.equals(defaultUserId)))
        .write(UsersCompanion(avatar: Value(avatarPath)));
  }

  /// Update username
  Future<void> updateUsername(String username) async {
    await (_db.update(_db.users)..where((t) => t.id.equals(defaultUserId)))
        .write(UsersCompanion(username: Value(username)));
  }
}
