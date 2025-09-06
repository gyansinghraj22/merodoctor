// lib/core/entities/user.dart
import 'package:equatable/equatable.dart';

abstract class UserEntity extends Equatable {
  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final String? profileImageUrl;

  const UserEntity({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    this.profileImageUrl,
  });

  @override
  List<Object?> get props => [
        userId,
        email,
        firstName,
        lastName,
        createdAt,
        profileImageUrl,
      ];
}