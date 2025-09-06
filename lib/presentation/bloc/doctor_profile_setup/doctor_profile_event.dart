
import 'package:equatable/equatable.dart';
import 'package:merodoctor/data/model/doctor_model.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object?> get props => [];
}

class LoadDoctorsEvent extends DoctorEvent {}

class AddDoctorEvent extends DoctorEvent {
  final DoctorModel doctorModel;

  const AddDoctorEvent(this.doctorModel);

  @override
  List<Object?> get props => [doctorModel];
}

class UpdateDoctorEvent extends DoctorEvent {
  final DoctorModel doctorModel;

  const UpdateDoctorEvent(this.doctorModel);

  @override
  List<Object?> get props => [doctorModel];
}

class FetchDoctorsByIdEvent extends DoctorEvent {
  final String id;
  const FetchDoctorsByIdEvent(this.id);
  @override
  List<Object> get props => [id];
}

class DeleteDoctorEvent extends DoctorEvent {
  final String doctorModelId;

  const DeleteDoctorEvent(this.doctorModelId);

  @override
  List<Object?> get props => [doctorModelId];
}