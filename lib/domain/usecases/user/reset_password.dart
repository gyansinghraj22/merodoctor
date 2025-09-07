// 6. Reset Password
import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/domain/repository/user_repository.dart';
import 'package:merodoctor/service_locator.dart';
class ResetPasswordUseCase implements UseCase<Either<Failure, void>, ResetPasswordParams> {
  @override
  Future<Either<Failure, void>> call({ResetPasswordParams? params}) async {
    return sl<UserRepository>().resetPassword(params!.email);
  }
}

class ResetPasswordParams {
  final String email;
  ResetPasswordParams(this.email);
}