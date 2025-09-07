
import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/data/model/doctor_model.dart';
import 'package:merodoctor/domain/repository/doctor_repository.dart';
import 'package:merodoctor/service_locator.dart';

class GetDoctorById implements UseCase<Either<Failure, DoctorModel>, String> {
  @override
  Future<Either<Failure, DoctorModel>> call({String? params}) async {
    // Call the getDoctorById method from the repository
    return sl<DoctorRepository>().getDoctorById(params!);
  }
}
