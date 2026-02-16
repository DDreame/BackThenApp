import 'package:equatable/equatable.dart';

class Feeling extends Equatable {
  final String id;
  final String content;
  final DateTime createdAt;
  final int replyCount;

  const Feeling({
    required this.id,
    required this.content,
    required this.createdAt,
    this.replyCount = 0,
  });

  Feeling copyWith({
    String? id,
    String? content,
    DateTime? createdAt,
    int? replyCount,
  }) {
    return Feeling(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      replyCount: replyCount ?? this.replyCount,
    );
  }

  @override
  List<Object?> get props => [id, content, createdAt, replyCount];
}
