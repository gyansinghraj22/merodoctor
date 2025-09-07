// lib/features/auth/data/repositories/user_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/model/user_model.dart';
import 'package:merodoctor/domain/repository/user_repository.dart';
import 'package:merodoctor/features/auth/domain/repositories/user_repository.dart';
import 'package:merodoctor/features/auth/data/models/user_model.dart';
import 'package:merodoctor/features/auth/data/datasources/auth_remote_data_source.dart';

/// Implements the [UserRepository] contract.
///
/// This class acts as a bridge, transforming data source responses into
/// domain-level results while handling exceptions and providing a clear
/// abstraction over the underlying Firebase Authentication system.
class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userModel =
          await remoteDataSource.signInWithEmailAndPassword(email, password);
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      // Map specific Firebase errors to our domain-level failures
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        return Left(UserNotFoundFailure());
      } else if (e.code == 'wrong-password') {
        return Left(WrongPasswordFailure());
      }
      return Left(AuthFailure());
    } on Exception {
      // Catch any other general exceptions
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final userModel =
          await remoteDataSource.registerWithEmailAndPassword(email, password);
      return Right(userModel);
    } on FirebaseAuthException {
      // Assuming email-already-in-use is the most common error here
      return Left(AuthFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Right(userModel);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateUserProfile(UserModel user) async {
    try {
      await remoteDataSource.updateUserProfile(user);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await remoteDataSource.resetPassword(email);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfUserExists(String email) async {
    try {
      final exists = await remoteDataSource.checkIfUserExists(email);
      return Right(exists);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}