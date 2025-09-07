
import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/data/model/user_model.dart';
import 'package:merodoctor/domain/repository/user_repository.dart';
import 'package:merodoctor/service_locator.dart';


class SignInUseCase implements UseCase<Either<Failure, UserModel>, SignInParams> {
  @override
  Future<Either<Failure, UserModel>> call({SignInParams? params}) async {
    return sl<UserRepository>()
        .signInWithEmailAndPassword(params!.email, params.password);
  }
}
class SignInParams {
  final String email;
  final String password;
  SignInParams(this.email, this.password);
}