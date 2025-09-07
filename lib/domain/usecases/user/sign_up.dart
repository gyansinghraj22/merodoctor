import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/data/model/user_model.dart';
import 'package:merodoctor/domain/repository/user_repository.dart';
import 'package:merodoctor/service_locator.dart';

class RegisterUseCase implements UseCase<Either<Failure, UserModel>, RegisterParams> {
  @override
  Future<Either<Failure, UserModel>> call({RegisterParams? params}) async {
    return sl<UserRepository>()
        .registerWithEmailAndPassword(params!.email, params.password);
  }
}

class RegisterParams {
  final String email;
  final String password;
  RegisterParams(this.email, this.password);
}