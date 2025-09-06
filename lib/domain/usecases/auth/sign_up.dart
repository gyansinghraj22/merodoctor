import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/data/model/create_user_model.dart';
import 'package:merodoctor/service_locator.dart';

import 'package:merodoctor/domain/repository/auth/auth_repository.dart';

class SignUpUseCase implements UseCase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) async {
    return sl<AuthRepository>().signup(params!);
  }
}
