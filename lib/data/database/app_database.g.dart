// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FeelingsTable extends Feelings with TableInfo<$FeelingsTable, Feeling> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeelingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _replyCountMeta = const VerificationMeta(
    'replyCount',
  );
  @override
  late final GeneratedColumn<int> replyCount = GeneratedColumn<int>(
    'reply_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, content, createdAt, replyCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feelings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Feeling> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('reply_count')) {
      context.handle(
        _replyCountMeta,
        replyCount.isAcceptableOrUnknown(data['reply_count']!, _replyCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Feeling map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Feeling(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      replyCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reply_count'],
      )!,
    );
  }

  @override
  $FeelingsTable createAlias(String alias) {
    return $FeelingsTable(attachedDatabase, alias);
  }
}

class Feeling extends DataClass implements Insertable<Feeling> {
  /// Unique identifier for the feeling entry
  final String id;

  /// The content/text of the feeling
  final String content;

  /// Timestamp when the feeling was created (millisecondsSinceEpoch)
  final int createdAt;

  /// Number of replies/replies to this feeling
  final int replyCount;
  const Feeling({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.replyCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<int>(createdAt);
    map['reply_count'] = Variable<int>(replyCount);
    return map;
  }

  FeelingsCompanion toCompanion(bool nullToAbsent) {
    return FeelingsCompanion(
      id: Value(id),
      content: Value(content),
      createdAt: Value(createdAt),
      replyCount: Value(replyCount),
    );
  }

  factory Feeling.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Feeling(
      id: serializer.fromJson<String>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      replyCount: serializer.fromJson<int>(json['replyCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<int>(createdAt),
      'replyCount': serializer.toJson<int>(replyCount),
    };
  }

  Feeling copyWith({
    String? id,
    String? content,
    int? createdAt,
    int? replyCount,
  }) => Feeling(
    id: id ?? this.id,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    replyCount: replyCount ?? this.replyCount,
  );
  Feeling copyWithCompanion(FeelingsCompanion data) {
    return Feeling(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      replyCount: data.replyCount.present
          ? data.replyCount.value
          : this.replyCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Feeling(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('replyCount: $replyCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, createdAt, replyCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Feeling &&
          other.id == this.id &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.replyCount == this.replyCount);
}

class FeelingsCompanion extends UpdateCompanion<Feeling> {
  final Value<String> id;
  final Value<String> content;
  final Value<int> createdAt;
  final Value<int> replyCount;
  final Value<int> rowid;
  const FeelingsCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.replyCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeelingsCompanion.insert({
    required String id,
    required String content,
    required int createdAt,
    this.replyCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       content = Value(content),
       createdAt = Value(createdAt);
  static Insertable<Feeling> custom({
    Expression<String>? id,
    Expression<String>? content,
    Expression<int>? createdAt,
    Expression<int>? replyCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (replyCount != null) 'reply_count': replyCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeelingsCompanion copyWith({
    Value<String>? id,
    Value<String>? content,
    Value<int>? createdAt,
    Value<int>? replyCount,
    Value<int>? rowid,
  }) {
    return FeelingsCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      replyCount: replyCount ?? this.replyCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (replyCount.present) {
      map['reply_count'] = Variable<int>(replyCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeelingsCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('replyCount: $replyCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RepliesTable extends Replies with TableInfo<$RepliesTable, Reply> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepliesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feelingIdMeta = const VerificationMeta(
    'feelingId',
  );
  @override
  late final GeneratedColumn<String> feelingId = GeneratedColumn<String>(
    'feeling_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeOffsetMeta = const VerificationMeta(
    'timeOffset',
  );
  @override
  late final GeneratedColumn<String> timeOffset = GeneratedColumn<String>(
    'time_offset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    feelingId,
    content,
    createdAt,
    timeOffset,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'replies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reply> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('feeling_id')) {
      context.handle(
        _feelingIdMeta,
        feelingId.isAcceptableOrUnknown(data['feeling_id']!, _feelingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_feelingIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('time_offset')) {
      context.handle(
        _timeOffsetMeta,
        timeOffset.isAcceptableOrUnknown(data['time_offset']!, _timeOffsetMeta),
      );
    } else if (isInserting) {
      context.missing(_timeOffsetMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reply map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reply(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      feelingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feeling_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      timeOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_offset'],
      )!,
    );
  }

  @override
  $RepliesTable createAlias(String alias) {
    return $RepliesTable(attachedDatabase, alias);
  }
}

class Reply extends DataClass implements Insertable<Reply> {
  /// Unique identifier for the reply
  final String id;

  /// ID of the feeling this reply belongs to
  final String feelingId;

  /// The content of the reply
  final String content;

  /// Timestamp when the reply was created (millisecondsSinceEpoch)
  final int createdAt;

  /// Time offset text describing when this reply was written (e.g., "1周后")
  final String timeOffset;
  const Reply({
    required this.id,
    required this.feelingId,
    required this.content,
    required this.createdAt,
    required this.timeOffset,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['feeling_id'] = Variable<String>(feelingId);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<int>(createdAt);
    map['time_offset'] = Variable<String>(timeOffset);
    return map;
  }

  RepliesCompanion toCompanion(bool nullToAbsent) {
    return RepliesCompanion(
      id: Value(id),
      feelingId: Value(feelingId),
      content: Value(content),
      createdAt: Value(createdAt),
      timeOffset: Value(timeOffset),
    );
  }

  factory Reply.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reply(
      id: serializer.fromJson<String>(json['id']),
      feelingId: serializer.fromJson<String>(json['feelingId']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      timeOffset: serializer.fromJson<String>(json['timeOffset']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'feelingId': serializer.toJson<String>(feelingId),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<int>(createdAt),
      'timeOffset': serializer.toJson<String>(timeOffset),
    };
  }

  Reply copyWith({
    String? id,
    String? feelingId,
    String? content,
    int? createdAt,
    String? timeOffset,
  }) => Reply(
    id: id ?? this.id,
    feelingId: feelingId ?? this.feelingId,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    timeOffset: timeOffset ?? this.timeOffset,
  );
  Reply copyWithCompanion(RepliesCompanion data) {
    return Reply(
      id: data.id.present ? data.id.value : this.id,
      feelingId: data.feelingId.present ? data.feelingId.value : this.feelingId,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      timeOffset: data.timeOffset.present
          ? data.timeOffset.value
          : this.timeOffset,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reply(')
          ..write('id: $id, ')
          ..write('feelingId: $feelingId, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('timeOffset: $timeOffset')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, feelingId, content, createdAt, timeOffset);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reply &&
          other.id == this.id &&
          other.feelingId == this.feelingId &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.timeOffset == this.timeOffset);
}

class RepliesCompanion extends UpdateCompanion<Reply> {
  final Value<String> id;
  final Value<String> feelingId;
  final Value<String> content;
  final Value<int> createdAt;
  final Value<String> timeOffset;
  final Value<int> rowid;
  const RepliesCompanion({
    this.id = const Value.absent(),
    this.feelingId = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.timeOffset = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RepliesCompanion.insert({
    required String id,
    required String feelingId,
    required String content,
    required int createdAt,
    required String timeOffset,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       feelingId = Value(feelingId),
       content = Value(content),
       createdAt = Value(createdAt),
       timeOffset = Value(timeOffset);
  static Insertable<Reply> custom({
    Expression<String>? id,
    Expression<String>? feelingId,
    Expression<String>? content,
    Expression<int>? createdAt,
    Expression<String>? timeOffset,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (feelingId != null) 'feeling_id': feelingId,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (timeOffset != null) 'time_offset': timeOffset,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RepliesCompanion copyWith({
    Value<String>? id,
    Value<String>? feelingId,
    Value<String>? content,
    Value<int>? createdAt,
    Value<String>? timeOffset,
    Value<int>? rowid,
  }) {
    return RepliesCompanion(
      id: id ?? this.id,
      feelingId: feelingId ?? this.feelingId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      timeOffset: timeOffset ?? this.timeOffset,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (feelingId.present) {
      map['feeling_id'] = Variable<String>(feelingId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (timeOffset.present) {
      map['time_offset'] = Variable<String>(timeOffset.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepliesCompanion(')
          ..write('id: $id, ')
          ..write('feelingId: $feelingId, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('timeOffset: $timeOffset, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('当时'),
  );
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _streakDaysMeta = const VerificationMeta(
    'streakDays',
  );
  @override
  late final GeneratedColumn<int> streakDays = GeneratedColumn<int>(
    'streak_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalFeelingsMeta = const VerificationMeta(
    'totalFeelings',
  );
  @override
  late final GeneratedColumn<int> totalFeelings = GeneratedColumn<int>(
    'total_feelings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    avatar,
    streakDays,
    totalFeelings,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('avatar')) {
      context.handle(
        _avatarMeta,
        avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta),
      );
    }
    if (data.containsKey('streak_days')) {
      context.handle(
        _streakDaysMeta,
        streakDays.isAcceptableOrUnknown(data['streak_days']!, _streakDaysMeta),
      );
    }
    if (data.containsKey('total_feelings')) {
      context.handle(
        _totalFeelingsMeta,
        totalFeelings.isAcceptableOrUnknown(
          data['total_feelings']!,
          _totalFeelingsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      avatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar'],
      ),
      streakDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak_days'],
      )!,
      totalFeelings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_feelings'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  /// Unique identifier for the user
  final String id;

  /// User's display name
  final String username;

  /// Avatar image path (nullable)
  final String? avatar;

  /// Number of consecutive days the user has recorded feelings
  final int streakDays;

  /// Total number of feelings recorded by the user
  final int totalFeelings;
  const User({
    required this.id,
    required this.username,
    this.avatar,
    required this.streakDays,
    required this.totalFeelings,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['username'] = Variable<String>(username);
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    map['streak_days'] = Variable<int>(streakDays);
    map['total_feelings'] = Variable<int>(totalFeelings);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      avatar: avatar == null && nullToAbsent
          ? const Value.absent()
          : Value(avatar),
      streakDays: Value(streakDays),
      totalFeelings: Value(totalFeelings),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      streakDays: serializer.fromJson<int>(json['streakDays']),
      totalFeelings: serializer.fromJson<int>(json['totalFeelings']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'avatar': serializer.toJson<String?>(avatar),
      'streakDays': serializer.toJson<int>(streakDays),
      'totalFeelings': serializer.toJson<int>(totalFeelings),
    };
  }

  User copyWith({
    String? id,
    String? username,
    Value<String?> avatar = const Value.absent(),
    int? streakDays,
    int? totalFeelings,
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    avatar: avatar.present ? avatar.value : this.avatar,
    streakDays: streakDays ?? this.streakDays,
    totalFeelings: totalFeelings ?? this.totalFeelings,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      streakDays: data.streakDays.present
          ? data.streakDays.value
          : this.streakDays,
      totalFeelings: data.totalFeelings.present
          ? data.totalFeelings.value
          : this.totalFeelings,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('avatar: $avatar, ')
          ..write('streakDays: $streakDays, ')
          ..write('totalFeelings: $totalFeelings')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, username, avatar, streakDays, totalFeelings);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.avatar == this.avatar &&
          other.streakDays == this.streakDays &&
          other.totalFeelings == this.totalFeelings);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> username;
  final Value<String?> avatar;
  final Value<int> streakDays;
  final Value<int> totalFeelings;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.avatar = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.totalFeelings = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    this.username = const Value.absent(),
    this.avatar = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.totalFeelings = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<String>? avatar,
    Expression<int>? streakDays,
    Expression<int>? totalFeelings,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (avatar != null) 'avatar': avatar,
      if (streakDays != null) 'streak_days': streakDays,
      if (totalFeelings != null) 'total_feelings': totalFeelings,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? username,
    Value<String?>? avatar,
    Value<int>? streakDays,
    Value<int>? totalFeelings,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      streakDays: streakDays ?? this.streakDays,
      totalFeelings: totalFeelings ?? this.totalFeelings,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (streakDays.present) {
      map['streak_days'] = Variable<int>(streakDays.value);
    }
    if (totalFeelings.present) {
      map['total_feelings'] = Variable<int>(totalFeelings.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('avatar: $avatar, ')
          ..write('streakDays: $streakDays, ')
          ..write('totalFeelings: $totalFeelings, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FeelingsTable feelings = $FeelingsTable(this);
  late final $RepliesTable replies = $RepliesTable(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    feelings,
    replies,
    users,
  ];
}

typedef $$FeelingsTableCreateCompanionBuilder =
    FeelingsCompanion Function({
      required String id,
      required String content,
      required int createdAt,
      Value<int> replyCount,
      Value<int> rowid,
    });
typedef $$FeelingsTableUpdateCompanionBuilder =
    FeelingsCompanion Function({
      Value<String> id,
      Value<String> content,
      Value<int> createdAt,
      Value<int> replyCount,
      Value<int> rowid,
    });

class $$FeelingsTableFilterComposer
    extends Composer<_$AppDatabase, $FeelingsTable> {
  $$FeelingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get replyCount => $composableBuilder(
    column: $table.replyCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeelingsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeelingsTable> {
  $$FeelingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get replyCount => $composableBuilder(
    column: $table.replyCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeelingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeelingsTable> {
  $$FeelingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get replyCount => $composableBuilder(
    column: $table.replyCount,
    builder: (column) => column,
  );
}

class $$FeelingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeelingsTable,
          Feeling,
          $$FeelingsTableFilterComposer,
          $$FeelingsTableOrderingComposer,
          $$FeelingsTableAnnotationComposer,
          $$FeelingsTableCreateCompanionBuilder,
          $$FeelingsTableUpdateCompanionBuilder,
          (Feeling, BaseReferences<_$AppDatabase, $FeelingsTable, Feeling>),
          Feeling,
          PrefetchHooks Function()
        > {
  $$FeelingsTableTableManager(_$AppDatabase db, $FeelingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeelingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeelingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeelingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> replyCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeelingsCompanion(
                id: id,
                content: content,
                createdAt: createdAt,
                replyCount: replyCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String content,
                required int createdAt,
                Value<int> replyCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeelingsCompanion.insert(
                id: id,
                content: content,
                createdAt: createdAt,
                replyCount: replyCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeelingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeelingsTable,
      Feeling,
      $$FeelingsTableFilterComposer,
      $$FeelingsTableOrderingComposer,
      $$FeelingsTableAnnotationComposer,
      $$FeelingsTableCreateCompanionBuilder,
      $$FeelingsTableUpdateCompanionBuilder,
      (Feeling, BaseReferences<_$AppDatabase, $FeelingsTable, Feeling>),
      Feeling,
      PrefetchHooks Function()
    >;
typedef $$RepliesTableCreateCompanionBuilder =
    RepliesCompanion Function({
      required String id,
      required String feelingId,
      required String content,
      required int createdAt,
      required String timeOffset,
      Value<int> rowid,
    });
typedef $$RepliesTableUpdateCompanionBuilder =
    RepliesCompanion Function({
      Value<String> id,
      Value<String> feelingId,
      Value<String> content,
      Value<int> createdAt,
      Value<String> timeOffset,
      Value<int> rowid,
    });

class $$RepliesTableFilterComposer
    extends Composer<_$AppDatabase, $RepliesTable> {
  $$RepliesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feelingId => $composableBuilder(
    column: $table.feelingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOffset => $composableBuilder(
    column: $table.timeOffset,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RepliesTableOrderingComposer
    extends Composer<_$AppDatabase, $RepliesTable> {
  $$RepliesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feelingId => $composableBuilder(
    column: $table.feelingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOffset => $composableBuilder(
    column: $table.timeOffset,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RepliesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepliesTable> {
  $$RepliesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get feelingId =>
      $composableBuilder(column: $table.feelingId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get timeOffset => $composableBuilder(
    column: $table.timeOffset,
    builder: (column) => column,
  );
}

class $$RepliesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepliesTable,
          Reply,
          $$RepliesTableFilterComposer,
          $$RepliesTableOrderingComposer,
          $$RepliesTableAnnotationComposer,
          $$RepliesTableCreateCompanionBuilder,
          $$RepliesTableUpdateCompanionBuilder,
          (Reply, BaseReferences<_$AppDatabase, $RepliesTable, Reply>),
          Reply,
          PrefetchHooks Function()
        > {
  $$RepliesTableTableManager(_$AppDatabase db, $RepliesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepliesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepliesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepliesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> feelingId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<String> timeOffset = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RepliesCompanion(
                id: id,
                feelingId: feelingId,
                content: content,
                createdAt: createdAt,
                timeOffset: timeOffset,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String feelingId,
                required String content,
                required int createdAt,
                required String timeOffset,
                Value<int> rowid = const Value.absent(),
              }) => RepliesCompanion.insert(
                id: id,
                feelingId: feelingId,
                content: content,
                createdAt: createdAt,
                timeOffset: timeOffset,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RepliesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepliesTable,
      Reply,
      $$RepliesTableFilterComposer,
      $$RepliesTableOrderingComposer,
      $$RepliesTableAnnotationComposer,
      $$RepliesTableCreateCompanionBuilder,
      $$RepliesTableUpdateCompanionBuilder,
      (Reply, BaseReferences<_$AppDatabase, $RepliesTable, Reply>),
      Reply,
      PrefetchHooks Function()
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      Value<String> username,
      Value<String?> avatar,
      Value<int> streakDays,
      Value<int> totalFeelings,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String> username,
      Value<String?> avatar,
      Value<int> streakDays,
      Value<int> totalFeelings,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalFeelings => $composableBuilder(
    column: $table.totalFeelings,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalFeelings => $composableBuilder(
    column: $table.totalFeelings,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalFeelings => $composableBuilder(
    column: $table.totalFeelings,
    builder: (column) => column,
  );
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<int> streakDays = const Value.absent(),
                Value<int> totalFeelings = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                avatar: avatar,
                streakDays: streakDays,
                totalFeelings: totalFeelings,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> username = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<int> streakDays = const Value.absent(),
                Value<int> totalFeelings = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                avatar: avatar,
                streakDays: streakDays,
                totalFeelings: totalFeelings,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FeelingsTableTableManager get feelings =>
      $$FeelingsTableTableManager(_db, _db.feelings);
  $$RepliesTableTableManager get replies =>
      $$RepliesTableTableManager(_db, _db.replies);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
