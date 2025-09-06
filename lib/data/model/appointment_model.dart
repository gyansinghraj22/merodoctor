// lib/features/appointment/data/models/appointment_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merodoctor/domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  const AppointmentModel({
    required super.appointmentId,
    required super.patientId,
    required super.doctorId,
    required super.appointmentTime,
    required super.durationMinutes,
    required super.status,
    required super.reasonForVisit,
    super.notes,
    super.paymentId,
  });

  factory AppointmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppointmentModel(
      appointmentId: doc.id,
      patientId: data['patientId'] as String,
      doctorId: data['doctorId'] as String,
      appointmentTime: (data['appointmentTime'] as Timestamp).toDate(),
      durationMinutes: data['durationMinutes'] as int,
      status: data['status'] as String,
      reasonForVisit: data['reasonForVisit'] as String,
      notes: data['notes'] as String?,
      paymentId: data['paymentId'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'patientId': patientId,
      'doctorId': doctorId,
      'appointmentTime': Timestamp.fromDate(appointmentTime),
      'durationMinutes': durationMinutes,
      'status': status,
      'reasonForVisit': reasonForVisit,
      'notes': notes,
      'paymentId': paymentId,
    };
  }
}