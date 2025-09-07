// lib/features/appointment/data/datasources/appointment_remote_data_source.dart

import 'package:merodoctor/data/model/appointment_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AppointmentRemoteDataSource {
  Future<AppointmentModel> getAppointmentById(String appointmentId);
  Future<List<AppointmentModel>> getUpcomingAppointments(String userId);
  Future<List<AppointmentModel>> getPastAppointments(String userId);
  Future<AppointmentModel> bookAppointment(AppointmentModel appointment);
  Future<void> updateAppointmentStatus(String appointmentId, String newStatus);
  Future<void> cancelAppointment(String appointmentId);
  Future<AppointmentModel> getAppointmentDetails(String appointmentId);
}

// lib/features/appointment/data/datasources/appointment_remote_data_source_impl.dart

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final FirebaseFirestore _firestore;

  AppointmentRemoteDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<AppointmentModel> getAppointmentById(String appointmentId) async {
    final doc = await _firestore.collection('appointments').doc(appointmentId).get();
    if (!doc.exists) {
      throw Exception('Appointment not found');
    }
    return AppointmentModel.fromFirestore(doc);
  }

  @override
  Future<List<AppointmentModel>> getUpcomingAppointments(String userId) async {
    final querySnapshot = await _firestore
        .collection('appointments')
        .where('patientId', isEqualTo: userId)
        .where('appointmentTime', isGreaterThanOrEqualTo: Timestamp.now())
        .orderBy('appointmentTime', descending: false)
        .get();
    return querySnapshot.docs.map((doc) => AppointmentModel.fromFirestore(doc)).toList();
  }

  @override
  Future<List<AppointmentModel>> getPastAppointments(String userId) async {
    final querySnapshot = await _firestore
        .collection('appointments')
        .where('patientId', isEqualTo: userId)
        .where('appointmentTime', isLessThan: Timestamp.now())
        .orderBy('appointmentTime', descending: true)
        .get();
    return querySnapshot.docs.map((doc) => AppointmentModel.fromFirestore(doc)).toList();
  }

  @override
  Future<AppointmentModel> bookAppointment(AppointmentModel appointment) async {
    final docRef = _firestore.collection('appointments').doc();
    final newAppointment = appointment;
    await docRef.set(newAppointment.toFirestore());
    return newAppointment;
  }

  @override
  Future<void> updateAppointmentStatus(String appointmentId, String newStatus) async {
    await _firestore
        .collection('appointments')
        .doc(appointmentId)
        .update({'status': newStatus});
  }

  @override
  Future<void> cancelAppointment(String appointmentId) async {
    await _firestore
        .collection('appointments')
        .doc(appointmentId)
        .update({'status': 'cancelled'});
  }

  @override
  Future<AppointmentModel> getAppointmentDetails(String appointmentId) async {
    final doc = await _firestore.collection('appointments').doc(appointmentId).get();
    if (!doc.exists) {
      throw Exception('Appointment details not found');
    }
    return AppointmentModel.fromFirestore(doc);
  }
}