import 'package:merodoctor/domain/entities/prescribtion_entity.dart'
    show PrescriptionEntity;

/// Represents the data model for a Prescription, extending PrescriptionEntity.
/// This class handles JSON serialization and deserialization.
class PrescriptionModel extends PrescriptionEntity {
  PrescriptionModel({
    required super.prescriptionId,
    required super.appointmentId,
    required super.doctorId,
    required super.patientId,
    required super.dateIssued,
    required super.notes,
  });

  /// Factory constructor to create a PrescriptionModel instance from a JSON map.
  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      PrescriptionModel(
        prescriptionId: json['prescriptionId'] as int,
        appointmentId: json['appointmentId'] as int,
        doctorId: json['doctorId'] as int,
        patientId: json['patientId'] as int,
        // Parse ISO 8601 string back to DateTime
        dateIssued: DateTime.parse(json['dateIssued'] as String),
        notes: json['notes'] as String,
      );

  /// Converts this PrescriptionModel instance to a JSON-compatible map.

  Map<String, dynamic> toJson() => {
    'prescriptionId': prescriptionId,
    'appointmentId': appointmentId,
    'doctorId': doctorId,
    'patientId': patientId,
    // Convert DateTime to ISO 8601 string for JSON serialization
    'dateIssued': dateIssued.toIso8601String(),
    'notes': notes,
  };
}
