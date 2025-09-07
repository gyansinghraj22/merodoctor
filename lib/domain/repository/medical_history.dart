// lib/features/medical_history/domain/repositories/medical_history_repository.dart

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/model/medical_record_model.dart';

abstract class MedicalHistoryRepository {
  /// Retrieves a patient's complete medical history.
  Future<Either<Failure, MedicalHistoryModel>> getMedicalHistory(
      String patientId);

  /// Updates a patient's medical history.
  Future<Either<Failure, void>> updateMedicalHistory(
      String patientId, MedicalHistoryModel medicalHistory);

  /// Adds a new consultation note to a patient's medical history.
  Future<Either<Failure, void>> addConsultationNote(
      String patientId, String doctorId, String notes);
}