
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merodoctor/data/model/medical_history_model.dart';

abstract class MedicalHistoryRemoteDataSource {
  Future<MedicalHistoryModel> getMedicalHistory(String patientId);
  Future<void> updateMedicalHistory(String patientId, MedicalHistoryModel medicalHistory);
  Future<void> addConsultationNote(String patientId, String doctorId, String notes);
}

class MedicalHistoryRemoteDataSourceImpl implements MedicalHistoryRemoteDataSource {
  final FirebaseFirestore _firestore;

  MedicalHistoryRemoteDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<MedicalHistoryModel> getMedicalHistory(String patientId) async {
    final doc = await _firestore.collection('patients').doc(patientId).get();
    if (!doc.exists) {
      throw Exception('Medical history not found');
    }
    final data = doc.data()!['medicalHistory'] as Map<String, dynamic>;
    return MedicalHistoryModel.fromFirestore(data);
  }

  @override
  Future<void> updateMedicalHistory(String patientId, MedicalHistoryModel medicalHistory) async {
    await _firestore
        .collection('patients')
        .doc(patientId)
        .update({'medicalHistory': medicalHistory.toFirestore()});
  }

  @override
  Future<void> addConsultationNote(String patientId, String doctorId, String notes) async {
    final newNote = {
      'doctorId': doctorId,
      'notes': notes,
      'timestamp': FieldValue.serverTimestamp(),
    };
    await _firestore.collection('patients').doc(patientId).collection('consultation_notes').add(newNote);
  }
}