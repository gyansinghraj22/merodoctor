
//7. Check If User Exists

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/domain/repository/user_repository.dart';
import 'package:merodoctor/service_locator.dart';
class CheckUserExistsUseCase implements UseCase<Either<Failure, bool>, CheckUserExistsParams> {
  @override
  Future<Either<Failure, bool>> call({CheckUserExistsParams? params}) async {
    return sl<UserRepository>().checkIfUserExists(params!.email);
  }
}

class CheckUserExistsParams {
  final String email;
  CheckUserExistsParams(this.email);
}