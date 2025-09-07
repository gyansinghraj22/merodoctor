// lib/features/prescription/data/repositories/prescription_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/data_source/prescribtion_remote_datasources.dart';
import 'package:merodoctor/data/model/prescription_model.dart';
import 'package:merodoctor/domain/repository/prescribtion_repository.dart';

/// Implements the [PrescriptionRepository] contract.
///
/// This class provides a professional interface for handling all prescription
/// operations, including creating, retrieving, updating, and deleting prescriptions.
class PrescriptionRepositoryImpl implements PrescriptionRepository {
  final PrescriptionRemoteDataSource remoteDataSource;

  PrescriptionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PrescriptionModel>> addPrescription(
    PrescriptionModel prescription,
  ) async {
    try {
      final result = await remoteDataSource.addPrescription(prescription);
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PrescriptionModel>> getPrescriptionById(
    String prescriptionId,
  ) async {
    try {
      final result = await remoteDataSource.getPrescriptionById(prescriptionId);
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PrescriptionModel>>> getPrescriptionsByPatient(
    String patientId,
  ) async {
    try {
      final result = await remoteDataSource.getPrescriptionsByPatient(
        patientId,
      );
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PrescriptionModel>>> getPrescriptionsByDoctor(
    String doctorId,
  ) async {
    try {
      final result = await remoteDataSource.getPrescriptionsByDoctor(doctorId);
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PrescriptionModel>> updatePrescription(
    PrescriptionModel prescription,
  ) async {
    try {
      await remoteDataSource.updatePrescription(prescription);
      return Right(prescription);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deletePrescription(
    String prescriptionId,
  ) async {
    try {
      await remoteDataSource.deletePrescription(prescriptionId);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
