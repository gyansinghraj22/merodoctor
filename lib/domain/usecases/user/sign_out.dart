import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/domain/repository/user_repository.dart';
import 'package:merodoctor/service_locator.dart';


class SignOutUseCase implements UseCase<Either<Failure, void>, NoParams> {
  @override
  Future<Either<Failure, void>> call({NoParams? params}) async {
    return sl<UserRepository>().signOut();
  }
}