// lib/features/prescription/data/models/prescription_medication_model.dart
import 'package:merodoctor/domain/entities/prescribtion_medication_entity.dart';

class PrescriptionMedicationModel extends PrescriptionMedicationEntity {
  const PrescriptionMedicationModel({
    required super.prescriptionMedicationId,
    required super.prescriptionId,
    required super.medicineName,
    required super.dosage,
    required super.frequency,
    required super.duration,
    super.instructions,
  });

  /// Factory from Firestore Map
  factory PrescriptionMedicationModel.fromMap(Map<String, dynamic> map) {
    return PrescriptionMedicationModel(
      prescriptionMedicationId: map['prescriptionMedicationId'] as String,
      prescriptionId: map['prescriptionId'] as String,
      medicineName: map['medicineName'] as String,
      dosage: map['dosage'] as String,
      frequency: map['frequency'] as String,
      duration: map['duration'] as String,
      instructions: map['instructions'] as String?,
    );
  }

  /// Convert to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'prescriptionMedicationId': prescriptionMedicationId,
      'prescriptionId': prescriptionId,
      'medicineName': medicineName,
      'dosage': dosage,
      'frequency': frequency,
      'duration': duration,
      'instructions': instructions,
    };
  }
}
