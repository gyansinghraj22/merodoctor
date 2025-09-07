import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/domain/repository/doctor_repository.dart';
import 'package:merodoctor/service_locator.dart';

class GetDoctors implements UseCase<Either, void> {
  @override
  Future<Either> call({void params}) async {
    return sl<DoctorRepository>().getDoctors();
  }
}
