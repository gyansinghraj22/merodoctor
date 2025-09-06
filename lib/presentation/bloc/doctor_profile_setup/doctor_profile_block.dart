import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merodoctor/core/usecase/usecase.dart';
import 'package:merodoctor/domain/usecases/doctor_usecase/delete_doctor.dart';
import 'package:merodoctor/domain/usecases/doctor_usecase/get_doctor_by_id.dart';
import 'package:merodoctor/domain/usecases/doctor_usecase/get_doctors.dart';
import 'package:merodoctor/domain/usecases/doctor_usecase/register_as_doctor.dart';
import 'package:merodoctor/domain/usecases/doctor_usecase/update_doctor_profile.dart';
import 'package:merodoctor/presentation/bloc/doctor_profile_setup/doctor_profile_event.dart';
import 'package:merodoctor/presentation/bloc/doctor_profile_setup/doctor_profile_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetDoctors getDoctors;
  final RegisterAsDoctor addDoctor;
  final UpdateDoctor updateDoctor;
  final DeleteDoctor deleteDoctor;
  final GetDoctorById getDoctorById;

  DoctorBloc({
    required this.getDoctorById,
    required this.getDoctors,
    required this.addDoctor,
    required this.updateDoctor,
    required this.deleteDoctor,
  }) : super(DoctorInitialState()) {
    // Load doctors
    on<LoadDoctorsEvent>((event, emit) async {
      emit(DoctorLoadingState());

      final result = await getDoctors(params: NoParams());

      result.fold(
        (failure) => emit(DoctorErrorState(failure.message)),
        (doctors) => emit(DoctorLoadedState(doctors)),
      );
    });

    // Add Doctor
    on<AddDoctorEvent>((event, emit) async {
      emit(DoctorLoadingState());

      final result = await addDoctor(params: event.doctorModel);

      result.fold((failure) => emit(DoctorErrorState(failure.message)), (
        newDoctor,
      ) {
        emit(DoctorAddedState(newDoctor));
        add(LoadDoctorsEvent()); // Reload doctors after adding
      });
    });

    // Update Doctor
    on<UpdateDoctorEvent>((event, emit) async {
      emit(DoctorLoadingState());

      final result = await updateDoctor(params: event.doctorModel);

      result.fold((failure) => emit(DoctorErrorState(failure.message)), (
        updatedDoctor,
      ) {
        emit(DoctorUpdatedState(updatedDoctor));
        add(LoadDoctorsEvent()); // Reload doctors after updating
      });
    });

    // Delete Doctor
    on<DeleteDoctorEvent>((event, emit) async {
      emit(DoctorLoadingState());

      final result = await deleteDoctor(params: event.doctorModelId);

      result.fold((failure) => emit(DoctorErrorState(failure.message)), (_) {
        emit(DoctorDeletedState(event.doctorModelId));
        add(LoadDoctorsEvent()); // Reload doctors after deleting
      });
    });
  }
}
