import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../models/feeling.dart' as models;
import '../database/app_database.dart';

/// Repository for managing Feeling entries in the database
class FeelingRepository {
  final AppDatabase _db;
  final Uuid _uuid = const Uuid();

  FeelingRepository(this._db);

  /// Convert Drift Feeling data class to domain Feeling model
  models.Feeling _toModel(Feeling data) {
    return models.Feeling(
      id: data.id,
      content: data.content,
      createdAt: DateTime.fromMillisecondsSinceEpoch(data.createdAt),
      replyCount: data.replyCount,
    );
  }

  /// Get all feelings ordered by createdAt DESC (newest first)
  Future<List<models.Feeling>> getAll() async {
    final results = await (_db.select(_db.feelings)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return results.map(_toModel).toList();
  }

  /// Get a single feeling by ID
  Future<models.Feeling?> getById(String id) async {
    final result = await (_db.select(_db.feelings)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return result != null ? _toModel(result) : null;
  }

  /// Create a new feeling with auto-generated ID and current timestamp
  Future<models.Feeling> create(String content) async {
    final id = _uuid.v4();
    final now = DateTime.now().millisecondsSinceEpoch;

    final companion = FeelingsCompanion(
      id: Value(id),
      content: Value(content),
      createdAt: Value(now),
      replyCount: const Value(0),
    );

    await _db.into(_db.feelings).insert(companion);

    return models.Feeling(
      id: id,
      content: content,
      createdAt: DateTime.fromMillisecondsSinceEpoch(now),
      replyCount: 0,
    );
  }

  /// Delete a feeling by ID
  Future<void> delete(String id) async {
    await (_db.delete(_db.feelings)..where((t) => t.id.equals(id))).go();
  }

  /// Get paginated feelings
  Future<List<models.Feeling>> getPaged(int limit, int offset) async {
    final results = await (_db.select(_db.feelings)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit, offset: offset))
        .get();
    return results.map(_toModel).toList();
  }

  /// Get total number of feelings
  Future<int> getTotalCount() async {
    final count = _db.feelings.id.count();
    final query = _db.selectOnly(_db.feelings)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Increment reply count for a feeling
  Future<void> incrementReplyCount(String feelingId) async {
    final feeling = await getById(feelingId);
    if (feeling != null) {
      await (_db.update(_db.feelings)..where((t) => t.id.equals(feelingId)))
          .write(FeelingsCompanion(replyCount: Value(feeling.replyCount + 1)));
    }
  }
}
