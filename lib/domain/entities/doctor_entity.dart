// lib/features/doctor/domain/entities/doctor_entity.dart
import 'package:merodoctor/domain/entities/user_entity.dart';

class DoctorEntity extends UserEntity {
  final String specialty;
  final String licenseNumber;
  final String bio;
  final String clinicAddress;
  final List<Map<String, dynamic>> workingHours;
  final double? averageRating;
  final List<String>? reviews;

  const DoctorEntity({
    required super.userId,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.createdAt,
    super.profileImageUrl,
    required this.specialty,
    required this.licenseNumber,
    required this.bio,
    required this.clinicAddress,
    required this.workingHours,
    this.averageRating,
    this.reviews,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        specialty,
        licenseNumber,
        bio,
        clinicAddress,
        workingHours,
        averageRating,
        reviews,
      ];
}