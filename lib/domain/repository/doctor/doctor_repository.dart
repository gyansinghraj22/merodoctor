
import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/model/doctor_model.dart';

abstract class DoctorRepository {
  Future<Either<Failure, DoctorModel>> registerAsDoctor(DoctorModel doctor);
  Future<Either<Failure, List<DoctorModel>>> getDoctors();
  Future<Either<Failure, DoctorModel>> getDoctorById(String doctorId);
  Future<Either<Failure, DoctorModel>> updateDoctor(DoctorModel doctor);
  Future<Either<Failure, void>> deleteAsDoctor(String doctorId);

}