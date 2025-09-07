import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merodoctor/data/model/prescription_model.dart';

abstract class PrescriptionRemoteDataSource {
  Future<PrescriptionModel> addPrescription(PrescriptionModel prescription);
  Future<PrescriptionModel> getPrescriptionById(String prescriptionId);
  Future<List<PrescriptionModel>> getPrescriptionsByPatient(String patientId);
  Future<List<PrescriptionModel>> getPrescriptionsByDoctor(String doctorId);
  Future<void> updatePrescription(PrescriptionModel prescription);
  Future<void> deletePrescription(String prescriptionId);
}

class PrescriptionRemoteDataSourceImpl implements PrescriptionRemoteDataSource {
  final FirebaseFirestore _firestore;

  PrescriptionRemoteDataSourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  CollectionReference get _prescriptions =>
      _firestore.collection('prescriptions');

  @override
  Future<PrescriptionModel> addPrescription(
    PrescriptionModel prescription,
  ) async {
    final docRef = _prescriptions.doc();
    final newPrescription = PrescriptionModel(
      prescriptionId: docRef.id,
      appointmentId: prescription.appointmentId,
      doctorId: prescription.doctorId,
      patientId: prescription.patientId,
      dateIssued: prescription.dateIssued,
      notes: prescription.notes,
      medications: prescription.medications,
    );

    await docRef.set(newPrescription.toFirestore());
    return newPrescription;
  }

  @override
  Future<PrescriptionModel> getPrescriptionById(String prescriptionId) async {
    final doc = await _prescriptions.doc(prescriptionId).get();
    if (!doc.exists) {
      throw Exception('Prescription not found');
    }
    return PrescriptionModel.fromFirestore(doc);
  }

  @override
  Future<List<PrescriptionModel>> getPrescriptionsByPatient(
    String patientId,
  ) async {
    final querySnapshot =
        await _prescriptions
            .where('patientId', isEqualTo: patientId)
            .orderBy('dateIssued', descending: true)
            .get();
    return querySnapshot.docs
        .map((doc) => PrescriptionModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<List<PrescriptionModel>> getPrescriptionsByDoctor(
    String doctorId,
  ) async {
    final querySnapshot =
        await _prescriptions
            .where('doctorId', isEqualTo: doctorId)
            .orderBy('dateIssued', descending: true)
            .get();
    return querySnapshot.docs
        .map((doc) => PrescriptionModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<void> updatePrescription(PrescriptionModel prescription) async {
    await _prescriptions
        .doc(prescription.prescriptionId)
        .update(prescription.toFirestore());
  }

  @override
  Future<void> deletePrescription(String prescriptionId) async {
    await _prescriptions.doc(prescriptionId).delete();
  }
}
