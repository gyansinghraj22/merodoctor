import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:merodoctor/data/model/doctor_model.dart';

abstract class DoctorRemoteDataSource {
  Future<Either<String, dynamic>> getDoctors();
  Future<Either<String, dynamic>> getDoctorById(String id);
  Future<Either<String, dynamic>> registerAsDoctor(DoctorModel doctor);
  Future<Either<String, dynamic>> updateDoctor(DoctorModel doctor);
  Future<Either<String, dynamic>> deleteAsDoctor(String id);
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final FirebaseFirestore firestore;
  final String collectionPath;

  DoctorRemoteDataSourceImpl(this.firestore, {this.collectionPath = 'doctors'});

  @override
  Future<Either<String, dynamic>> getDoctors() async {
    try {
      final snapshot = await firestore.collection(collectionPath).get();
      if (snapshot.docs.isEmpty) {
        return Left('No Doctors found');
      }
      final doctors =
          snapshot.docs.map((doc) => DoctorModel.fromJson(doc.data())).toList();
      return Right(doctors);
    } catch (e) {
      return Left('Error fetching doctors: $e');
    }
  }

  @override
  Future<Either<String, dynamic>> getDoctorById(String id) async {
    try {
      final doc = await firestore.collection(collectionPath).doc(id).get();
      if (!doc.exists) {
        return Left('Doctor not found');
      }
      final doctor = DoctorModel.fromJson(doc.data()!);
      return Right(doctor);
    } catch (e) {
      return Left('Error fetching doctor: $e');
    }
  }

  @override
  Future<Either<String, dynamic>> registerAsDoctor(DoctorModel doctor) async {
    try {
      await firestore
          .collection(collectionPath)
          .doc(doctor.doctorId)
          .set(doctor.toJson());
      return Right('Doctor created successfully');
    } catch (e) {
      return Left('Failed to create doctor: $e');
    }
  }

  @override
  Future<Either<String, dynamic>> updateDoctor(DoctorModel doctor) async {
    try {
      await firestore
          .collection(collectionPath)
          .doc(doctor.doctorId)
          .update(doctor.toJson());
      return Right('Doctor updated successfully');
    } catch (e) {
      return Left('Failed to update doctor: $e');
    }
  }

  @override
  Future<Either<String, dynamic>> deleteAsDoctor(String id) async {
    try {
      await firestore.collection(collectionPath).doc(id).delete();
      return Right('Doctor deleted successfully');
    } catch (e) {
      return Left('Failed to delete doctor: $e');
    }
  }
}
