import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

/// Table for storing mood/feeling entries
class Feelings extends Table {
  /// Unique identifier for the feeling entry
  TextColumn get id => text()();

  /// The content/text of the feeling
  TextColumn get content => text()();

  /// Timestamp when the feeling was created (millisecondsSinceEpoch)
  IntColumn get createdAt => integer()();

  /// Number of replies/replies to this feeling
  IntColumn get replyCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table for storing future perspective replies to feelings
class Replies extends Table {
  /// Unique identifier for the reply
  TextColumn get id => text()();

  /// ID of the feeling this reply belongs to
  TextColumn get feelingId => text()();

  /// The content of the reply
  TextColumn get content => text()();

  /// Timestamp when the reply was created (millisecondsSinceEpoch)
  IntColumn get createdAt => integer()();

  /// Time offset text describing when this reply was written (e.g., "1周后")
  TextColumn get timeOffset => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table for storing user profile data
class Users extends Table {
  /// Unique identifier for the user
  TextColumn get id => text()();

  /// User's display name
  TextColumn get username => text().withDefault(const Constant('当时'))();

  /// Avatar image path (nullable)
  TextColumn get avatar => text().nullable()();

  /// Number of consecutive days the user has recorded feelings
  IntColumn get streakDays => integer().withDefault(const Constant(0))();

  /// Total number of feelings recorded by the user
  IntColumn get totalFeelings => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Feelings, Replies, Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor for testing with custom executor (e.g., in-memory database)
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle future schema migrations here
        // Example:
        // if (from < 2) {
        //   await m.addColumn(feelings, feelings.newColumn);
        // }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'dangshi.db'));
    return NativeDatabase.createInBackground(file);
  });
}