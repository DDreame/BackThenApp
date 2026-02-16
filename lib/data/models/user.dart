import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String? avatar;
  final int streakDays;
  final int totalFeelings;

  const User({
    required this.id,
    this.username = '当时',
    this.avatar,
    this.streakDays = 0,
    this.totalFeelings = 0,
  });

  User copyWith({
    String? id,
    String? username,
    String? avatar,
    int? streakDays,
    int? totalFeelings,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      streakDays: streakDays ?? this.streakDays,
      totalFeelings: totalFeelings ?? this.totalFeelings,
    );
  }

  @override
  List<Object?> get props => [id, username, avatar, streakDays, totalFeelings];
}
