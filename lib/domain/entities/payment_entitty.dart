// lib/core/entities/payment.dart
import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final String paymentId;
  final String userId;
  final String appointmentId;
  final double amount;
  final String currency;
  final String status;
  final DateTime timestamp;
  final String paymentMethod;

  const PaymentEntity({
    required this.paymentId,
    required this.userId,
    required this.appointmentId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.timestamp,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [
        paymentId,
        userId,
        appointmentId,
        amount,
        currency,
        status,
        timestamp,
        paymentMethod,
      ];
}