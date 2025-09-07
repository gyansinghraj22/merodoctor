// lib/features/medical_history/data/models/medical_history_model.dart
import 'package:merodoctor/domain/entities/medical_record_entity.dart';

class MedicalHistoryModel extends MedicalHistoryEntity {
  const MedicalHistoryModel({
    required super.conditions,
    required super.allergies,
    required super.medications,
    required super.surgeries,
    required super.immunizations,
    required super.familyHistory,
  });

  factory MedicalHistoryModel.fromFirestore(Map<String, dynamic> data) {
    return MedicalHistoryModel(
      conditions: List<Map<String, dynamic>>.from(data['conditions']),
      allergies: List<String>.from(data['allergies']),
      medications: List<Map<String, dynamic>>.from(data['medications']),
      surgeries: List<Map<String, dynamic>>.from(data['surgeries']),
      immunizations: List<Map<String, dynamic>>.from(data['immunizations']),
      familyHistory: List<Map<String, dynamic>>.from(data['familyHistory']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'conditions': conditions,
      'allergies': allergies,
      'medications': medications,
      'surgeries': surgeries,
      'immunizations': immunizations,
      'familyHistory': familyHistory,
    };
  }
}