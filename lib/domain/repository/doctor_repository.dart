
import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/model/doctor_model.dart';


abstract class DoctorRepository {
  /// Retrieves a specific doctor's profile by their ID.
  Future<Either<Failure, DoctorModel>> getDoctorById(String doctorId);

  /// Retrieves a list of doctors based on their medical specialty.
  Future<Either<Failure, List<DoctorModel>>> getDoctorsBySpecialty(
      String specialty);

  /// Retrieves a list of all available doctors in the system.
  Future<Either<Failure, List<DoctorModel>>> getAllDoctors();

  /// Retrieves a list of available time slots for a given doctor on a specific date.
  Future<Either<Failure, List<DateTime>>> getAvailableTimeSlots(
      String doctorId, DateTime date);

  /// Creates a new doctor record.
  Future<Either<Failure, void>> createDoctor(DoctorModel doctor);

  /// Updates an existing doctor's profile.
  Future<Either<Failure, void>> updateDoctor(DoctorModel doctor);

  /// Deletes a doctor's record.
  Future<Either<Failure, void>> deleteDoctor(String doctorId);
}