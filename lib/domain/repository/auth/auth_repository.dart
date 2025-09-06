import 'package:dartz/dartz.dart';
import 'package:merodoctor/data/model/create_user_model.dart';
import 'package:merodoctor/data/model/login_user_model.dart';


abstract class AuthRepository {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> login(LoginUserReq loginUserReq);
  
}
