class PrescriptionEntity {
  final int prescriptionId;
  final int appointmentId;
  final int doctorId;
  final int patientId;
  final DateTime dateIssued;
  final String notes;

  PrescriptionEntity({
    required this.prescriptionId,
    required this.appointmentId,
    required this.doctorId,
    required this.patientId,
    required this.dateIssued,
    required this.notes,
  });
}
