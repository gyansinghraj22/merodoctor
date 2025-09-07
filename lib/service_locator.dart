import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:merodoctor/data/data_source/auth_remote_data_sources.dart';

GetIt sl = GetIt.instance;
Future<void> initializeDependencies() async {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}
