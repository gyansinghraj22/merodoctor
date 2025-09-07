import 'package:merodoctor/domain/entities/prescribtion_medication_entity.dart';

class PrescriptionEntity {
  final String prescriptionId;
  final String appointmentId;
  final String doctorId;
  final String patientId;
  final DateTime dateIssued;
  final String? notes;
  final List<PrescriptionMedicationEntity> medications;

  const PrescriptionEntity({
    required this.prescriptionId,
    required this.appointmentId,
    required this.doctorId,
    required this.patientId,
    required this.dateIssued,
    this.notes,
    this.medications = const [],
  });
}
