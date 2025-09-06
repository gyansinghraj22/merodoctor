// lib/core/entities/medical_history.dart
import 'package:equatable/equatable.dart';

class MedicalHistoryEntity extends Equatable {
  final List<Map<String, dynamic>> conditions;
  final List<String> allergies;
  final List<Map<String, dynamic>> medications;
  final List<Map<String, dynamic>> surgeries;
  final List<Map<String, dynamic>> immunizations;
  final List<Map<String, dynamic>> familyHistory;

  const MedicalHistoryEntity({
    required this.conditions,
    required this.allergies,
    required this.medications,
    required this.surgeries,
    required this.immunizations,
    required this.familyHistory,
  });

  @override
  List<Object?> get props => [
        conditions,
        allergies,
        medications,
        surgeries,
        immunizations,
        familyHistory,
      ];
}