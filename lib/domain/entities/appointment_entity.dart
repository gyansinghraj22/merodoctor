// lib/core/entities/appointment.dart
import 'package:equatable/equatable.dart';

class AppointmentEntity extends Equatable {
  final String appointmentId;
  final String patientId;
  final String doctorId;
  final DateTime appointmentTime;
  final int durationMinutes;
  final String status;
  final String reasonForVisit;
  final String? notes;
  final String? paymentId;

  const AppointmentEntity({
    required this.appointmentId,
    required this.patientId,
    required this.doctorId,
    required this.appointmentTime,
    required this.durationMinutes,
    required this.status,
    required this.reasonForVisit,
    this.notes,
    this.paymentId,
  });

  @override
  List<Object?> get props => [
        appointmentId,
        patientId,
        doctorId,
        appointmentTime,
        durationMinutes,
        status,
        reasonForVisit,
        notes,
        paymentId,
      ];
}