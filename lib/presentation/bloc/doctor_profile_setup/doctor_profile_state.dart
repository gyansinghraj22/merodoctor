import 'package:equatable/equatable.dart';
import 'package:merodoctor/data/model/doctor_model.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object?> get props => [];
}

class DoctorInitialState extends DoctorState {}

class DoctorLoadingState extends DoctorState {}

class DoctorLoadedState extends DoctorState {
  final List<DoctorModel> doctorModel; // Make sure this is DoctorModel not DoctorEntity

  const DoctorLoadedState(this.doctorModel);

  @override
  List<Object?> get props => [doctorModel];
}

class DoctorErrorState extends DoctorState {
  final String message;

  const DoctorErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class DoctorAddedState extends DoctorState {
  final DoctorModel doctorModel; // Make sure this is DoctorModel not DoctorEntity

  const DoctorAddedState(this.doctorModel);

  @override
  List<Object?> get props => [doctorModel];
}

class DoctorUpdatedState extends DoctorState {
  final DoctorModel doctorModel; // Make sure this is DoctorModel not DoctorEntity

  const DoctorUpdatedState(this.doctorModel);

  @override
  List<Object?> get props => [doctorModel];
}

class DoctorDeletedState extends DoctorState {
  final String doctorId;

  const DoctorDeletedState(this.doctorId);

  @override
  List<Object?> get props => [doctorId];
}
