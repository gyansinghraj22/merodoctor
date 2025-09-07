class PrescriptionMedicationEntity {
  final String prescriptionMedicationId;
  final String prescriptionId;
  final String medicineName;
  final String dosage;        // e.g. "500mg"
  final String frequency;     // e.g. "2 times/day"
  final String duration;      // e.g. "7 days"
  final String? instructions; // e.g. "After meals"

  const PrescriptionMedicationEntity({
    required this.prescriptionMedicationId,
    required this.prescriptionId,
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    this.instructions,
  });
}
