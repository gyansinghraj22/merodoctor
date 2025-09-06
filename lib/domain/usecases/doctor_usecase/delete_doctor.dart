
import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/domain/repository/doctor/doctor_repository.dart';
import 'package:merodoctor/service_locator.dart';


class DeleteDoctor implements UseCase<Either<Failure, void>, String> {
  @override
  Future<Either<Failure,void>> call({String? params}) async {
    // Call the deleteDoctor method from the repository
    return sl<DoctorRepository>().deleteAsDoctor(params!);
  }
}