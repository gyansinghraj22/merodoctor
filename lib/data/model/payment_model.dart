// lib/features/payment/data/models/payment_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merodoctor/domain/entities/payment_entitty.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.paymentId,
    required super.userId,
    required super.appointmentId,
    required super.amount,
    required super.currency,
    required super.status,
    required super.timestamp,
    required super.paymentMethod,
  });

  factory PaymentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PaymentModel(
      paymentId: doc.id,
      userId: data['userId'] as String,
      appointmentId: data['appointmentId'] as String,
      amount: (data['amount'] as num).toDouble(),
      currency: data['currency'] as String,
      status: data['status'] as String,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'appointmentId': appointmentId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'timestamp': Timestamp.fromDate(timestamp),
      'paymentMethod': paymentMethod,
    };
  }
}