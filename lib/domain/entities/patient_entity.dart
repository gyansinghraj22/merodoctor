// lib/features/patient/domain/entities/patient_entity.dart
import 'package:equatable/equatable.dart';
import 'package:merodoctor/domain/entities/user_entity.dart';


class PatientEntity extends UserEntity {
  final DateTime dateOfBirth;
  final Map<String, dynamic> contactInfo;
  final Map<String, dynamic> insuranceInfo;
  final MedicalHistoryEntity medicalHistory;

  const PatientEntity({
    required super.userId,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.createdAt,
    super.profileImageUrl,
    required this.dateOfBirth,
    required this.contactInfo,
    required this.insuranceInfo,
    required this.medicalHistory,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        dateOfBirth,
        contactInfo,
        insuranceInfo,
        medicalHistory,
      ];
}