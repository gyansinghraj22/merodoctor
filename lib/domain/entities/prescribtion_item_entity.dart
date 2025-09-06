class PrescriptionItemEntity {
  final int prescriptionItemId;
  final int prescriptionId;
  final String medicationName;
  final String dosage;
  final String instructions;
  final String duration;

  PrescriptionItemEntity({
    required this.prescriptionItemId,
    required this.prescriptionId,
    required this.medicationName,
    required this.dosage,
    required this.instructions,
    required this.duration,
  });
}
