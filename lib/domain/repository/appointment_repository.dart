// lib/features/appointment/domain/repositories/appointment_repository.dart

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/model/appointment_model.dart';

abstract class AppointmentRepository {
  /// Retrieves a single appointment by its unique ID.
  Future<Either<Failure, AppointmentModel>> getAppointmentById(
      String appointmentId);

  /// Retrieves a list of all upcoming appointments for a user.
  Future<Either<Failure, List<AppointmentModel>>> getUpcomingAppointments(
      String userId);

  /// Retrieves a list of all past appointments for a user.
  Future<Either<Failure, List<AppointmentModel>>> getPastAppointments(
      String userId);

  /// Books a new appointment for a patient with a doctor.
  Future<Either<Failure, AppointmentModel>> bookAppointment(
      AppointmentModel appointment);

  /// Updates the status of an existing appointment.
  Future<Either<Failure, void>> updateAppointmentStatus(
      String appointmentId, String newStatus);

  /// Cancels a specific appointment.
  Future<Either<Failure, void>> cancelAppointment(String appointmentId);

  /// Retrieves the details of a completed appointment.
  Future<Either<Failure, AppointmentModel>> getAppointmentDetails(
      String appointmentId);
}