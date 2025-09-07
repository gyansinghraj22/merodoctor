
import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/data/model/login_user_model.dart';
import 'package:merodoctor/domain/repository/auth_repository.dart';
import 'package:merodoctor/service_locator.dart';


class LoginUseCase implements UseCase<Either, LoginUserReq> {
  @override
  Future<Either> call({LoginUserReq? params}) async {
    return sl<AuthRepository>().login(params!);
  }
}
