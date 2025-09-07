// lib/domain/repositories/prescription_repository.dart
import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/model/prescription_model.dart';

abstract class PrescriptionRepository {
  /// Create a new prescription
  Future<Either<Failure, PrescriptionModel>> addPrescription(PrescriptionModel prescription);

  /// Get prescription by ID
  Future<Either<Failure, PrescriptionModel>> getPrescriptionById(String prescriptionId);

  /// Get all prescriptions of a patient
  Future<Either<Failure, List<PrescriptionModel>>> getPrescriptionsByPatient(String patientId);

  /// Get all prescriptions created by a doctor
  Future<Either<Failure, List<PrescriptionModel>>> getPrescriptionsByDoctor(String doctorId);

  /// Update an existing prescription
  Future<Either<Failure, PrescriptionModel>> updatePrescription(PrescriptionModel prescription);

  /// Delete prescription by ID
  Future<Either<Failure, void>> deletePrescription(String prescriptionId);
}
