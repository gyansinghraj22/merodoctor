// lib/features/medical_history/data/repositories/medical_history_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/data_source/medical_history_datasources.dart';
import 'package:merodoctor/data/model/medical_history_model.dart';
import 'package:merodoctor/domain/repository/medical_history_repository.dart';

/// Implements the [MedicalHistoryRepository] contract.
///
/// This class handles the secure access and modification of a patient's
/// medical history, abstracting the underlying data source.
class MedicalHistoryRepositoryImpl implements MedicalHistoryRepository {
  final MedicalHistoryRemoteDataSource remoteDataSource;

  MedicalHistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MedicalHistoryModel>> getMedicalHistory(
      String patientId) async {
    try {
      final history = await remoteDataSource.getMedicalHistory(patientId);
      return Right(history);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateMedicalHistory(
      String patientId, MedicalHistoryModel medicalHistory) async {
    try {
      await remoteDataSource.updateMedicalHistory(patientId, medicalHistory);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addConsultationNote(
      String patientId, String doctorId, String notes) async {
    try {
      await remoteDataSource.addConsultationNote(
          patientId, doctorId, notes);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}