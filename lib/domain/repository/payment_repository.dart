// lib/features/payment/domain/repositories/payment_repository.dart

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/model/payment_model.dart';

abstract class PaymentRepository {
  /// Processes a payment for a specific appointment.
  Future<Either<Failure, PaymentModel>> processPayment(PaymentModel payment);

  /// Retrieves the details of a single payment by its ID.
  Future<Either<Failure, PaymentModel>> getPaymentById(String paymentId);

  /// Retrieves a list of a user's past payment transactions.
  Future<Either<Failure, List<PaymentModel>>> getPaymentHistory(String userId);

  /// Checks the current status of a payment (e.g., succeeded, failed).
  Future<Either<Failure, String>> checkPaymentStatus(String paymentId);
}