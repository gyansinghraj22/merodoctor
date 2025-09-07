import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:merodoctor/data/data_source/auth_firebase_source.dart';
import 'package:merodoctor/data/data_source/doctor_remote_datasource.dart';
import 'package:merodoctor/data/repository_impl/auth_repository_impl.dart';
import 'package:merodoctor/data/repository_impl/doctor_repository_impl.dart';
import 'package:merodoctor/domain/repository/auth_repository.dart';
import 'package:merodoctor/domain/repository/doctor_repository.dart';
import 'package:merodoctor/domain/usecases/auth/login.dart';
import 'package:merodoctor/domain/usecases/auth/sign_up.dart';
import 'package:merodoctor/domain/usecases/doctor_usecase/delete_doctor.dart';
import 'package:merodoctor/domain/usecases/doctor_usecase/get_doctor_by_id.dart';
import 'package:merodoctor/domain/usecases/doctor_usecase/get_doctors.dart';
import 'package:merodoctor/domain/usecases/doctor_usecase/register_as_doctor.dart';
import 'package:merodoctor/domain/usecases/doctor_usecase/update_doctor_profile.dart';
import 'package:merodoctor/presentation/bloc/doctor_profile_setup/doctor_profile_block.dart';

GetIt sl = GetIt.instance;
Future<void> initializeDependencies() async {
  sl.registerLazySingleton<AuthFirebaseServices>(
    () => AuthFirebaseServicesImpl(),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase());
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase());

  //datasource
  sl.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSourceImpl(sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<DoctorRepository>(() => DoctorRepositoryImpl());

  // Usecases
  sl.registerLazySingleton<RegisterAsDoctor>(() => RegisterAsDoctor());
  sl.registerLazySingleton<UpdateDoctor>(() => UpdateDoctor());
  sl.registerLazySingleton<DeleteDoctor>(() => DeleteDoctor());
  sl.registerLazySingleton<GetDoctors>(() => GetDoctors());
  sl.registerLazySingleton<GetDoctorById>(() => GetDoctorById());

  sl.registerFactory(
    () => DoctorBloc(
      getDoctorById: sl<GetDoctorById>(),
      getDoctors: sl<GetDoctors>(),
      addDoctor: sl<RegisterAsDoctor>(),
      updateDoctor: sl<UpdateDoctor>(),
      deleteDoctor: sl<DeleteDoctor>(),
    ),
  );
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}
