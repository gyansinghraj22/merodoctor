// lib/features/admin/domain/entities/admin_entity.dart
import 'package:merodoctor/domain/entities/user_entity.dart';

class AdminEntity extends UserEntity {
  const AdminEntity({
    required super.userId,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.createdAt,
    super.profileImageUrl,
  });
}