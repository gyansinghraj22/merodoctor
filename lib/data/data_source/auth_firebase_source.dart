import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:merodoctor/data/model/create_user_model.dart';
import 'package:merodoctor/data/model/login_user_model.dart';


abstract class AuthFirebaseServices {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> login(LoginUserReq loginUserReq);
}

class AuthFirebaseServicesImpl implements AuthFirebaseServices {
  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );
      FirebaseFirestore.instance.collection("users").add({
        'name': createUserReq.fullName,
        'email': data.user?.email,
      });

      return Right("SignUp was SuccessFull");
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> login(LoginUserReq loginUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginUserReq.email,
        password: loginUserReq.password,
      );
      return Right("Login was SuccessFull");
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credentials') {
        message = 'Wrong password provided for that user.';
      }
      return Left(message);
    }
  }
}
