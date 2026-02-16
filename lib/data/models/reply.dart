import 'package:equatable/equatable.dart';

class Reply extends Equatable {
  final String id;
  final String feelingId;
  final String content;
  final DateTime createdAt;
  final String timeOffset;

  const Reply({
    required this.id,
    required this.feelingId,
    required this.content,
    required this.createdAt,
    required this.timeOffset,
  });

  Reply copyWith({
    String? id,
    String? feelingId,
    String? content,
    DateTime? createdAt,
    String? timeOffset,
  }) {
    return Reply(
      id: id ?? this.id,
      feelingId: feelingId ?? this.feelingId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      timeOffset: timeOffset ?? this.timeOffset,
    );
  }

  @override
  List<Object?> get props => [id, feelingId, content, createdAt, timeOffset];
}
