import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:merodoctor/data/model/payment_model.dart';

abstract class PaymentRemoteDatasource {
   Future<Either<String, dynamic>> getPayments();
  Future<Either<String, List<PaymentModel>>> getPaymentsByUser(String userId);

  Future<Either<String, dynamic>> getPaymentById(String id);
  Future<Either<String, dynamic>> createPayment(PaymentModel payment);
  Future<Either<String, dynamic>> updatePayment(PaymentModel payment);
  Future<Either<String, dynamic>> deletePayment(String id);
}


class PaymentRemoteDataSourceImpl implements PaymentRemoteDatasource {
  final FirebaseFirestore firestore;
  final String collectionPath;

  PaymentRemoteDataSourceImpl(
    this.firestore, {
    this.collectionPath = 'payments',
  });

  @override
  Future<Either<String, List<PaymentModel>>> getPaymentsByUser(
    String userId,
  ) async {
    if (userId.isEmpty) return Left('Invalid user ID');

    try {
      final snapshot =
          await firestore
              .collection(collectionPath)
              .where('userId', isEqualTo: userId)
              .get();

      if (snapshot.docs.isEmpty) return Left('No payments found for this user');

      final payments =
          snapshot.docs
              .map(
                (doc) =>
                    PaymentModel.fromJson({...doc.data(), 'paymentId': doc.id}),
              )
              .toList();

      return Right(payments);
    } catch (e) {
      return Left('Failed to fetch user payments: $e');
    }
  }

  @override
  Future<Either<String, List<PaymentModel>>> getPayments() async {
    try {
      final snapshot =
          await firestore
              .collection(collectionPath)
              .where(
                'userId',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid,
              )
              .get();
      if (snapshot.docs.isEmpty) return Left('No payments found');

      final payments =
          snapshot.docs
              .map(
                (doc) =>
                    PaymentModel.fromJson({...doc.data(), 'paymentId': doc.id}),
              )
              .toList();

      return Right(payments);
    } catch (e) {
      return Left('Failed to fetch payments: $e');
    }
  }

  //   Future<Either<String, List<PaymentModel>>> getPayments({required String userId}) async {
  //   if (userId.isEmpty) return Left('Invalid user ID');

  //   try {
  //     final snapshot = await firestore
  //         .collection(collectionPath)
  //         .where('userId', isEqualTo: userId) // Filter by current user
  //         .get();

  //     if (snapshot.docs.isEmpty) return Left('No payments found for this user');

  //     final payments = snapshot.docs
  //         .map((doc) => PaymentModel.fromJson({
  //               ...doc.data(),
  //               'paymentId': doc.id,
  //             }))
  //         .toList();

  //     return Right(payments);
  //   } catch (e) {
  //     return Left('Failed to fetch payments: $e');
  //   }
  // }

  @override
  Future<Either<String, PaymentModel>> getPaymentById(String id) async {
    if (id.isEmpty) return Left('Invalid payment ID');

    try {
      final doc = await firestore.collection(collectionPath).doc(id).get();
      if (!doc.exists) return Left('Payment not found');

      final payment = PaymentModel.fromJson({
        ...doc.data()!,
        'paymentId': doc.id,
      });

      return Right(payment);
    } catch (e) {
      return Left('Failed to fetch payment: $e');
    }
  }

  @override
  Future<Either<String, String>> createPayment(PaymentModel payment) async {
    try {
      // Generate ID if empty
      final docRef =
          payment.paymentId.isNotEmpty
              ? firestore.collection(collectionPath).doc(payment.paymentId)
              : firestore.collection(collectionPath).doc();

      await docRef.set(payment.toJson());

      return Right('Payment created successfully');
    } catch (e) {
      return Left('Failed to create payment: $e');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> updatePayment(
    PaymentModel payment,
  ) async {
    if (payment.paymentId.isEmpty) return Left('Invalid payment ID');

    try {
      final docRef = firestore
          .collection(collectionPath)
          .doc(payment.paymentId);
      await docRef.update(payment.toJson());

      final updatedDoc = await docRef.get();
      return Right(updatedDoc.data()!);
    } catch (e) {
      return Left('Failed to update payment: $e');
    }
  }

  @override
  Future<Either<String, String>> deletePayment(String id) async {
    if (id.isEmpty) return Left('Invalid payment ID');

    try {
      await firestore.collection(collectionPath).doc(id).delete();
      return Right('Payment deleted successfully');
    } catch (e) {
      return Left('Failed to delete payment: $e');
    }
  }
}
