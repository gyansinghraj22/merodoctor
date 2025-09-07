// lib/features/payment/data/datasources/payment_
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merodoctor/data/model/payment_model.dart';


abstract class PaymentRemoteDataSource {
  Future<PaymentModel> processPayment(PaymentModel payment);
  Future<PaymentModel> getPaymentById(String paymentId);
  Future<List<PaymentModel>> getPaymentHistory(String userId);
  Future<String> checkPaymentStatus(String paymentId);
}
// lib/features/payment/data/datasources/payment_remote_data_source_impl.dart

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final FirebaseFirestore _firestore;

  PaymentRemoteDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<PaymentModel> processPayment(PaymentModel payment) async {
    // In a real-world scenario, this would involve a call to a secure
    // payment gateway (like Stripe or PayPal) via a server-side function.
    // Here, we simulate a successful transaction by storing it in Firestore.
    final docRef = _firestore.collection('payments').doc();
    final newPayment = payment;
    await docRef.set(newPayment.toFirestore());
    return newPayment;
  }

  @override
  Future<PaymentModel> getPaymentById(String paymentId) async {
    final doc = await _firestore.collection('payments').doc(paymentId).get();
    if (!doc.exists) {
      throw Exception('Payment not found');
    }
    return PaymentModel.fromFirestore(doc);
  }

  @override
  Future<List<PaymentModel>> getPaymentHistory(String userId) async {
    final querySnapshot = await _firestore
        .collection('payments')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();
    return querySnapshot.docs.map((doc) => PaymentModel.fromFirestore(doc)).toList();
  }

  @override
  Future<String> checkPaymentStatus(String paymentId) async {
    final doc = await _firestore.collection('payments').doc(paymentId).get();
    if (!doc.exists) {
      throw Exception('Payment not found');
    }
    return doc.data()!['status'] as String;
  }
}