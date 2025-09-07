// lib/features/doctor/data/repositories/doctor_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/data_source/doctor_remote_datasource.dart';
import 'package:merodoctor/data/model/doctor_model.dart';
import 'package:merodoctor/domain/repository/doctor_repository.dart';

/// Implements the [DoctorRepository] contract.
///
/// This class encapsulates all logic for retrieving and modifying doctor-related
/// data, providing a single point of access for the domain layer.
class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DoctorModel>> getDoctorById(String doctorId) async {
    try {
      final doctorModel = await remoteDataSource.getDoctorById(doctorId);
      return Right(doctorModel);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorsBySpecialty(
      String specialty) async {
    try {
      final doctors = await remoteDataSource.getDoctorsBySpecialty(specialty);
      return Right(doctors);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getAllDoctors() async {
    try {
      final doctors = await remoteDataSource.getAllDoctors();
      return Right(doctors);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<DateTime>>> getAvailableTimeSlots(
      String doctorId, DateTime date) async {
    try {
      final slots =
          await remoteDataSource.getAvailableTimeSlots(doctorId, date);
      return Right(slots);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createDoctor(DoctorModel doctor) async {
    try {
      await remoteDataSource.createDoctor(doctor);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateDoctor(DoctorModel doctor) async {
    try {
      await remoteDataSource.updateDoctor(doctor);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteDoctor(String doctorId) async {
    try {
      await remoteDataSource.deleteDoctor(doctorId);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}