import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/data/model/user_model.dart';
import 'package:merodoctor/domain/repository/user_repository.dart';
import 'package:merodoctor/service_locator.dart';

class GetCurrentUserUseCase implements UseCase<Either<Failure, UserModel?>, NoParams> {
  @override
  Future<Either<Failure, UserModel?>> call({NoParams? params}) async {
    return sl<UserRepository>().getCurrentUser();
  }
}
