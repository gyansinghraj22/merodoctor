// lib/features/auth/domain/repositories/user_repository.dart

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/model/user_model.dart';

abstract class UserRepository {
  /// Signs in a user with their email and password.
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      String email, String password);

  /// Registers a new user with their email and password.
  Future<Either<Failure, UserModel>> registerWithEmailAndPassword(
      String email, String password);

  /// Signs out the currently authenticated user.
  Future<Either<Failure, void>> signOut();

  /// Retrieves the currently authenticated user's profile.
  Future<Either<Failure, UserModel?>> getCurrentUser();

  /// Updates a user's profile information.
  Future<Either<Failure, void>> updateUserProfile(UserModel user);

  /// Resets a user's password via email.
  Future<Either<Failure, void>> resetPassword(String email);

  /// Checks if a user with a specific email address already exists.
  Future<Either<Failure, bool>> checkIfUserExists(String email);
}