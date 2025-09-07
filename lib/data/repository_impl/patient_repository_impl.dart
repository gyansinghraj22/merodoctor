// lib/features/patient/data/repositories/patient_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/data_source/patient_remote_datasources.dart';
import 'package:merodoctor/data/model/patient_model.dart';
import 'package:merodoctor/domain/repository/patient_repository.dart';

/// Implements the [PatientRepository] contract.
///
/// This class handles all patient data requests by calling the appropriate
/// remote data source method and managing the flow of data and exceptions.
class PatientRepositoryImpl implements PatientRepository {
  final PatientRemoteDataSource remoteDataSource;

  PatientRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PatientModel>> getPatientById(String patientId) async {
    try {
      final patientModel = await remoteDataSource.getPatientById(patientId);
      return Right(patientModel);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createPatient(PatientModel patient) async {
    try {
      await remoteDataSource.createPatient(patient);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updatePatient(PatientModel patient) async {
    try {
      await remoteDataSource.updatePatient(patient);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deletePatient(String patientId) async {
    try {
      await remoteDataSource.deletePatient(patientId);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PatientModel>> getPatientProfileData(
      String patientId) async {
    try {
      final patientModel =
          await remoteDataSource.getPatientProfileData(patientId);
      return Right(patientModel);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}