import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merodoctor/core/configs/theme/app_theme.dart';
import 'package:merodoctor/firebase_options.dart';
import 'package:merodoctor/presentation/bloc/doctor_profile_setup/doctor_profile_block.dart';
import 'package:merodoctor/presentation/bloc/theme_cubit.dart';
import 'package:merodoctor/presentation/pages/authentication/sign_login_page.dart';
import 'package:merodoctor/service_locator.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (context) => sl<DoctorBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder:
            (context, mode) => MaterialApp(
              debugShowCheckedModeBanner: false,
              darkTheme: AppTheme.darkTheme,
              theme: AppTheme.lightTheme,

              themeMode: mode,
              home: const SignupOrSigninPage(),
            ),
      ),
    );
  }
}
