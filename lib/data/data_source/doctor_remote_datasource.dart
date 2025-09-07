// lib/features/doctor/data/datasources/doctor_remote_data_source.dart


import 'package:merodoctor/data/model/doctor_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DoctorRemoteDataSource {
  Future<DoctorModel> getDoctorById(String doctorId);
  Future<List<DoctorModel>> getDoctorsBySpecialty(String specialty);
  Future<List<DoctorModel>> getAllDoctors();
  Future<List<DateTime>> getAvailableTimeSlots(String doctorId, DateTime date);
  Future<void> createDoctor(DoctorModel doctor);
  Future<void> updateDoctor(DoctorModel doctor);
  Future<void> deleteDoctor(String doctorId);
}
// lib/features/doctor/data/datasources/doctor_remote_data_source_impl.dart

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final FirebaseFirestore _firestore;

  DoctorRemoteDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<DoctorModel> getDoctorById(String doctorId) async {
    final doc = await _firestore.collection('doctors').doc(doctorId).get();
    if (!doc.exists) {
      throw Exception('Doctor not found');
    }
    return DoctorModel.fromFirestore(doc);
  }

  @override
  Future<List<DoctorModel>> getDoctorsBySpecialty(String specialty) async {
    final querySnapshot = await _firestore
        .collection('doctors')
        .where('specialty', isEqualTo: specialty)
        .get();
    return querySnapshot.docs.map((doc) => DoctorModel.fromFirestore(doc)).toList();
  }

  @override
  Future<List<DoctorModel>> getAllDoctors() async {
    final querySnapshot = await _firestore.collection('doctors').get();
    return querySnapshot.docs.map((doc) => DoctorModel.fromFirestore(doc)).toList();
  }

  @override
  Future<List<DateTime>> getAvailableTimeSlots(String doctorId, DateTime date) async {
    // This is a simplified example; a real-world implementation would involve
    // checking both the doctor's set working hours and existing appointments.
    // This method would then compute and return the available slots.
    final doc = await _firestore.collection('doctors').doc(doctorId).get();
    if (!doc.exists) {
      throw Exception('Doctor not found');
    }
    // Example: dummy data for a professional response
    return [
      DateTime(date.year, date.month, date.day, 9, 0),
      DateTime(date.year, date.month, date.day, 10, 0),
      DateTime(date.year, date.month, date.day, 11, 0),
    ];
  }

  @override
  Future<void> createDoctor(DoctorModel doctor) async {
    await _firestore.collection('doctors').doc(doctor.userId).set(doctor.toFirestore());
  }

  @override
  Future<void> updateDoctor(DoctorModel doctor) async {
    await _firestore.collection('doctors').doc(doctor.userId).update(doctor.toFirestore());
  }

  @override
  Future<void> deleteDoctor(String doctorId) async {
    await _firestore.collection('doctors').doc(doctorId).delete();
  }
}