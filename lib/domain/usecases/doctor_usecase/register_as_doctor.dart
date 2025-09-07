import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/data/model/doctor_model.dart';
import 'package:merodoctor/domain/repository/doctor_repository.dart';
import 'package:merodoctor/service_locator.dart';

class RegisterAsDoctor implements UseCase<Either, DoctorModel> {
  @override
  Future<Either> call({DoctorModel? params}) async {
    // Call the updateBike method from the repository
    return sl<DoctorRepository>().registerAsDoctor(params!);
  }
}