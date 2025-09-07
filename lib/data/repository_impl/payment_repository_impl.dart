// lib/features/payment/data/repositories/payment_repository_impl.dart

import 'package:dartz/dartz.dart';

/// Implements the [PaymentRepository] contract.
///
/// This class provides a professional interface for handling all payment
/// operations, including processing transactions and fetching payment history.
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaymentModel>> processPayment(PaymentModel payment) async {
    try {
      final processedPayment = await remoteDataSource.processPayment(payment);
      return Right(processedPayment);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PaymentModel>> getPaymentById(String paymentId) async {
    try {
      final payment = await remoteDataSource.getPaymentById(paymentId);
      return Right(payment);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PaymentModel>>> getPaymentHistory(String userId) async {
    try {
      final history = await remoteDataSource.getPaymentHistory(userId);
      return Right(history);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> checkPaymentStatus(String paymentId) async {
    try {
      final status = await remoteDataSource.checkPaymentStatus(paymentId);
      return Right(status);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}