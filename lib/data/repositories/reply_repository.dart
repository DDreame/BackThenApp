import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../models/reply.dart' as models;
import '../database/app_database.dart';

/// Repository for managing Reply entries in the database
class ReplyRepository {
  final AppDatabase _db;
  final Uuid _uuid = const Uuid();

  ReplyRepository(this._db);

  /// Convert Drift Reply data class to domain Reply model
  models.Reply _toModel(Reply data) {
    return models.Reply(
      id: data.id,
      feelingId: data.feelingId,
      content: data.content,
      createdAt: DateTime.fromMillisecondsSinceEpoch(data.createdAt),
      timeOffset: data.timeOffset,
    );
  }

  /// Get all replies for a feeling, ordered by createdAt ASC (oldest first)
  Future<List<models.Reply>> getByFeelingId(String feelingId) async {
    final results = await (_db.select(_db.replies)
          ..where((t) => t.feelingId.equals(feelingId))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
    return results.map(_toModel).toList();
  }

  /// Create a new reply
  Future<models.Reply> create(
    String feelingId,
    String content,
    String timeOffset,
  ) async {
    final id = _uuid.v4();
    final now = DateTime.now().millisecondsSinceEpoch;

    final companion = RepliesCompanion(
      id: Value(id),
      feelingId: Value(feelingId),
      content: Value(content),
      createdAt: Value(now),
      timeOffset: Value(timeOffset),
    );

    await _db.into(_db.replies).insert(companion);

    return models.Reply(
      id: id,
      feelingId: feelingId,
      content: content,
      createdAt: DateTime.fromMillisecondsSinceEpoch(now),
      timeOffset: timeOffset,
    );
  }

  /// Delete a reply by ID
  Future<void> delete(String id) async {
    await (_db.delete(_db.replies)..where((t) => t.id.equals(id))).go();
  }

  /// Get reply count for a feeling
  Future<int> getCountByFeelingId(String feelingId) async {
    final count = _db.replies.id.count();
    final query = _db.selectOnly(_db.replies)
      ..addColumns([count])
      ..where(_db.replies.feelingId.equals(feelingId));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }
}
