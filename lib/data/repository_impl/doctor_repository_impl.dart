import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/data_source/doctor_remote_datasource.dart';
import 'package:merodoctor/data/model/doctor_model.dart';
import 'package:merodoctor/domain/repository/doctor/doctor_repository.dart';
import 'package:merodoctor/service_locator.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource = sl<DoctorRemoteDataSource>();
  // final BikeRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctors() async {
    final result = await remoteDataSource.getDoctors();
    return result.fold((error) => Left(ServerFailure(error)), (doctors) {
      if (doctors is List) {
        final List<DoctorModel> doctorList = doctors.cast<DoctorModel>();
        return Right(doctorList);
      } else {
        return Left(ServerFailure('Unexpected data type'));
      }
    });
  }

  @override
  Future<Either<Failure, DoctorModel>> getDoctorById(String id) async {
    try {
      final result = await remoteDataSource.getDoctorById(id);
      return result.fold((error) => Left(ServerFailure(error)), (doctor) {
        if (doctor is DoctorModel) {
          return Right(doctor);
        } else {
          return Left(ServerFailure('Unexpected data type'));
        }
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorModel>> updateDoctor(DoctorModel doctor) async {
    final result = await remoteDataSource.updateDoctor(doctor);
    return result.fold(
      (error) => left((ServerFailure(error))),
      (doctor) => Right(DoctorModel.fromJson(doctor)),
    );
  }
  @override
  Future<Either<Failure, void>> deleteAsDoctor(String id) async {
    final result = await remoteDataSource.deleteAsDoctor(id);
    return result.fold(
      (error) => Left(ServerFailure(error)),
      (success) => Right(null),
    );
  }

  @override
  Future<Either<Failure, DoctorModel>> registerAsDoctor(
    DoctorModel doctor,
  ) async {
    final result = await remoteDataSource.registerAsDoctor(doctor);
    return result.fold((error) => Left(ServerFailure(error)), (success) {
      return Right(doctor);
    });
  }
}
