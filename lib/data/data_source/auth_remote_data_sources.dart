// lib/features/auth/data/datasources/auth_remote_data_source.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merodoctor/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';


/// The contract for the authentication remote data source.
///
/// This abstract class defines the methods for authentication and user profile
/// management without specifying the underlying technology (e.g., Firebase).
abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> registerWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Future<void> updateUserProfile(UserModel user);
  Future<void> resetPassword(String email);
  Future<bool> checkIfUserExists(String email);
}
// lib/features/auth/data/datasources/auth_remote_data_source_impl.dart


/// Implements the [AuthRemoteDataSource] using Firebase services.
///
/// This class handles direct communication with Firebase Auth and Firestore
/// for all authentication-related tasks. It throws specific exceptions on
/// failure, which are then caught and mapped by the repository layer.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  
  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).get();

    return UserModel.fromFirestore(userDoc);
  }

  @override
  Future<UserModel> registerWithEmailAndPassword(
      String email, String password) async {
    final authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
    final newUser = UserModel(
      userId: authResult.user!.uid,
      email: email,
      firstName: '',
      lastName: '',
      createdAt: DateTime.now(),
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(newUser.userId)
        .set(newUser.toFirestore());

    return newUser;
  }

  @override
  Future<void> signOut() => FirebaseAuth.instance.signOut();

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    return UserModel.fromFirestore(userDoc);
  }

  @override
  Future<void> updateUserProfile(UserModel user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.userId)
        .update(user.toFirestore());
  }

  @override
  Future<void> resetPassword(String email) =>
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);

  @override
  Future<bool> checkIfUserExists(String email) async {
    final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    return signInMethods.isNotEmpty;
  }
}