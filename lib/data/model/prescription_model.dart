// lib/features/prescription/data/models/prescription_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merodoctor/data/model/prescribtion_medication_model.dart';
import 'package:merodoctor/domain/entities/prescribtion_entity.dart';


class PrescriptionModel extends PrescriptionEntity {
  const PrescriptionModel({
    required super.prescriptionId,
    required super.appointmentId,
    required super.doctorId,
    required super.patientId,
    required super.dateIssued,
    super.notes,
    super.medications,
  });

  /// Factory to create a model from Firestore document
  factory PrescriptionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return PrescriptionModel(
      prescriptionId: doc.id,
      appointmentId: data['appointmentId'] as String,
      doctorId: data['doctorId'] as String,
      patientId: data['patientId'] as String,
      dateIssued: (data['dateIssued'] as Timestamp).toDate(),
      notes: data['notes'] as String?,
      medications: (data['medications'] as List<dynamic>?)
              ?.map((med) => PrescriptionMedicationModel.fromMap(
                  med as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Convert to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'appointmentId': appointmentId,
      'doctorId': doctorId,
      'patientId': patientId,
      'dateIssued': Timestamp.fromDate(dateIssued),
      'notes': notes,
      'medications':
          medications.map((med) => (med as PrescriptionMedicationModel).toMap()).toList(),
    };
  }
}
