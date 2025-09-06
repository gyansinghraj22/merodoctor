// lib/features/patient/data/models/patient_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merodoctor/data/model/medical_record_model.dart';
import 'package:merodoctor/domain/entities/patient_entity.dart';


class PatientModel extends PatientEntity {
  const PatientModel({
    required super.userId,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.createdAt,
    super.profileImageUrl,
    required super.dateOfBirth,
    required super.contactInfo,
    required super.insuranceInfo,
    required super.medicalHistory,
  });

  factory PatientModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PatientModel(
      userId: doc.id,
      email: data['email'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      profileImageUrl: data['profileImageUrl'] as String?,
      dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
      contactInfo: data['contactInfo'] as Map<String, dynamic>,
      insuranceInfo: data['insuranceInfo'] as Map<String, dynamic>,
      medicalHistory: MedicalHistoryModel.fromFirestore(
          data['medicalHistory'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': Timestamp.fromDate(createdAt),
      'profileImageUrl': profileImageUrl,
      'dateOfBirth': Timestamp.fromDate(dateOfBirth),
      'contactInfo': contactInfo,
      'insuranceInfo': insuranceInfo,
      'medicalHistory': (medicalHistory as MedicalHistoryModel).toFirestore(),
    };
  }
}