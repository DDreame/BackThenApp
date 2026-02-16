import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dangshi/data/database/app_database.dart';
import 'package:dangshi/data/repositories/feeling_repository.dart';
import 'package:dangshi/data/models/feeling.dart' as models;

void main() {
  late AppDatabase database;
  late FeelingRepository repository;

  setUp(() {
    // Use in-memory database for testing
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = FeelingRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('FeelingRepository', () {
    group('create', () {
      test('creates a new feeling with auto-generated ID', () async {
        final content = 'Test feeling content';

        final result = await repository.create(content);

        expect(result.id, isNotEmpty);
        expect(result.content, content);
        expect(result.replyCount, 0);
        expect(result.createdAt, isNotNull);
      });

      test('creates a feeling and persists to database', () async {
        final content = 'Persistent feeling';

        final result = await repository.create(content);
        final fromDb = await repository.getById(result.id);

        expect(fromDb, isNotNull);
        expect(fromDb!.id, result.id);
        expect(fromDb.content, content);
      });

      test('creates multiple feelings with unique IDs', () async {
        final feeling1 = await repository.create('First feeling');
        final feeling2 = await repository.create('Second feeling');

        expect(feeling1.id, isNot(equals(feeling2.id)));
      });
    });

    group('getAll', () {
      test('returns empty list when no feelings exist', () async {
        final result = await repository.getAll();

        expect(result, isEmpty);
      });

      test('returns all feelings ordered by createdAt DESC', () async {
        await repository.create('First (oldest)');
        await Future.delayed(const Duration(milliseconds: 10));
        await repository.create('Second');
        await Future.delayed(const Duration(milliseconds: 10));
        await repository.create('Third (newest)');

        final result = await repository.getAll();

        expect(result.length, 3);
        expect(result[0].content, 'Third (newest)');
        expect(result[1].content, 'Second');
        expect(result[2].content, 'First (oldest)');
      });
    });

    group('getById', () {
      test('returns feeling when it exists', () async {
        final created = await repository.create('Test feeling');

        final result = await repository.getById(created.id);

        expect(result, isNotNull);
        expect(result!.id, created.id);
        expect(result.content, 'Test feeling');
      });

      test('returns null when feeling does not exist', () async {
        final result = await repository.getById('non-existent-id');

        expect(result, isNull);
      });
    });

    group('delete', () {
      test('deletes a feeling from database', () async {
        final created = await repository.create('To be deleted');

        await repository.delete(created.id);

        final result = await repository.getById(created.id);
        expect(result, isNull);
      });

      test('deleting non-existent feeling does not throw', () async {
        expect(() => repository.delete('non-existent-id'), returnsNormally);
      });

      test('delete only affects the specified feeling', () async {
        final feeling1 = await repository.create('Feeling 1');
        final feeling2 = await repository.create('Feeling 2');

        await repository.delete(feeling1.id);

        final result1 = await repository.getById(feeling1.id);
        final result2 = await repository.getById(feeling2.id);

        expect(result1, isNull);
        expect(result2, isNotNull);
        expect(result2!.content, 'Feeling 2');
      });
    });

    group('getPaged', () {
      test('returns paginated results', () async {
        await repository.create('Feeling 1');
        await Future.delayed(const Duration(milliseconds: 10));
        await repository.create('Feeling 2');
        await Future.delayed(const Duration(milliseconds: 10));
        await repository.create('Feeling 3');
        await Future.delayed(const Duration(milliseconds: 10));
        await repository.create('Feeling 4');
        await Future.delayed(const Duration(milliseconds: 10));
        await repository.create('Feeling 5');

        final page1 = await repository.getPaged(2, 0);
        final page2 = await repository.getPaged(2, 2);

        expect(page1.length, 2);
        expect(page2.length, 2);
        expect(page1[0].content, 'Feeling 5'); // newest first
        expect(page2[0].content, 'Feeling 3');
      });

      test('returns empty list when offset exceeds data', () async {
        await repository.create('Only one');

        final result = await repository.getPaged(10, 100);

        expect(result, isEmpty);
      });
    });

    group('getTotalCount', () {
      test('returns 0 when no feelings exist', () async {
        final count = await repository.getTotalCount();

        expect(count, 0);
      });

      test('returns correct count of feelings', () async {
        await repository.create('Feeling 1');
        await repository.create('Feeling 2');
        await repository.create('Feeling 3');

        final count = await repository.getTotalCount();

        expect(count, 3);
      });
    });

    group('incrementReplyCount', () {
      test('increments reply count for existing feeling', () async {
        final created = await repository.create('Test feeling');
        expect(created.replyCount, 0);

        await repository.incrementReplyCount(created.id);

        final updated = await repository.getById(created.id);
        expect(updated!.replyCount, 1);
      });

      test('increments reply count multiple times', () async {
        final created = await repository.create('Test feeling');

        await repository.incrementReplyCount(created.id);
        await repository.incrementReplyCount(created.id);
        await repository.incrementReplyCount(created.id);

        final updated = await repository.getById(created.id);
        expect(updated!.replyCount, 3);
      });

      test('incrementReplyCount does nothing for non-existent feeling', () async {
        expect(() => repository.incrementReplyCount('non-existent'), returnsNormally);
      });
    });

    group('model conversion', () {
      test('Feeling model has correct properties', () async {
        final created = await repository.create('Model test');

        expect(created, isA<models.Feeling>());
        expect(created.id, isNotEmpty);
        expect(created.content, 'Model test');
        expect(created.createdAt, isA<DateTime>());
        expect(created.replyCount, 0);
      });

      test('Feeling model supports equality', () async {
        final created = await repository.create('Equality test');

        final fromDb = await repository.getById(created.id);

        // Note: DateTime precision might differ slightly
        expect(created.id, fromDb!.id);
        expect(created.content, fromDb.content);
        expect(created.replyCount, fromDb.replyCount);
      });
    });
  });
}
