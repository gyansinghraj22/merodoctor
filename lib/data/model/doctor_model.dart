// lib/features/doctor/data/models/doctor_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merodoctor/domain/entities/doctor_entity.dart';


class DoctorModel extends DoctorEntity {
  const DoctorModel({
    required super.userId,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.createdAt,
    super.profileImageUrl,
    required super.specialty,
    required super.licenseNumber,
    required super.bio,
    required super.clinicAddress,
    required super.workingHours,
    super.averageRating,
    super.reviews,
  });

  factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DoctorModel(
      userId: doc.id,
      email: data['email'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      profileImageUrl: data['profileImageUrl'] as String?,
      specialty: data['specialty'] as String,
      licenseNumber: data['licenseNumber'] as String,
      bio: data['bio'] as String,
      clinicAddress: data['clinicAddress'] as String,
      workingHours: List<Map<String, dynamic>>.from(data['workingHours']),
      averageRating: (data['averageRating'] as num?)?.toDouble(),
      reviews: List<String>.from(data['reviews'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': Timestamp.fromDate(createdAt),
      'profileImageUrl': profileImageUrl,
      'specialty': specialty,
      'licenseNumber': licenseNumber,
      'bio': bio,
      'clinicAddress': clinicAddress,
      'workingHours': workingHours,
      'averageRating': averageRating,
      'reviews': reviews,
    };
  }
}