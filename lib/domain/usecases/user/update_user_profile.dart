// 5. Update User Profile

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/data/model/user_model.dart';
import 'package:merodoctor/domain/repository/user_repository.dart';
import 'package:merodoctor/service_locator.dart';

class UpdateUserProfileUseCase
    implements UseCase<Either<Failure, void>, UserModel> {
  @override
  Future<Either<Failure, void>> call({UserModel? params}) async {
    return sl<UserRepository>().updateUserProfile(params!);
  }
}
