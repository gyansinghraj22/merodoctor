// lib/features/patient/data/datasources/patient_remote_data_source.dart

import 'package:merodoctor/data/model/patient_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


abstract class PatientRemoteDataSource {
  Future<PatientModel> getPatientById(String patientId);
  Future<void> createPatient(PatientModel patient);
  Future<void> updatePatient(PatientModel patient);
  Future<void> deletePatient(String patientId);
  Future<PatientModel> getPatientProfileData(String patientId);
}

class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  final FirebaseFirestore _firestore;

  PatientRemoteDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<PatientModel> getPatientById(String patientId) async {
    final doc = await _firestore.collection('patients').doc(patientId).get();
    if (!doc.exists) {
      throw Exception('Patient not found');
    }
    return PatientModel.fromFirestore(doc);
  }

  @override
  Future<void> createPatient(PatientModel patient) async {
    await _firestore
        .collection('patients')
        .doc(patient.userId)
        .set(patient.toFirestore());
  }

  @override
  Future<void> updatePatient(PatientModel patient) async {
    await _firestore
        .collection('patients')
        .doc(patient.userId)
        .update(patient.toFirestore());
  }

  @override
  Future<void> deletePatient(String patientId) async {
    await _firestore.collection('patients').doc(patientId).delete();
  }

  @override
  Future<PatientModel> getPatientProfileData(String patientId) async {
    final doc = await _firestore.collection('patients').doc(patientId).get();
    if (!doc.exists) {
      throw Exception('Patient profile not found');
    }
    return PatientModel.fromFirestore(doc);
  }
}