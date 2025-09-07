// lib/features/patient/domain/repositories/patient_repository.dart

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/model/patient_model.dart';

abstract class PatientRepository {
  /// Retrieves a complete patient profile by their ID.
  Future<Either<Failure, PatientModel>> getPatientById(String patientId);

  /// Creates a new patient record in the database.
  Future<Either<Failure, void>> createPatient(PatientModel patient);

  /// Updates a patient's profile information.
  Future<Either<Failure, void>> updatePatient(PatientModel patient);

  /// Deletes a patient's record from the database.
  Future<Either<Failure, void>> deletePatient(String patientId);

  /// Retrieves a patient's medical history and contact information.
  Future<Either<Failure, PatientModel>> getPatientProfileData(String patientId);
}