import 'package:dating_app/repository/auth/auth_repo.dart';
import 'package:dating_app/repository/database/db_repository.dart';
import 'package:dating_app/repository/storage/storage_repository.dart';
import 'package:dating_app/routing/app_routing.dart';
import 'package:dating_app/screens/splash_scren/splash_screen.dart';
import 'package:dating_app/telegram/telegram_sdk.dart';
import 'package:dating_app/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/profile/profile_bloc.dart';
import 'bloc/swipe_bloc/swipe_bloc.dart';
import 'cubit/registration/registration_cubit.dart';
import 'cubit/signup/signup_cubit.dart';
import 'model/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Future.delayed(const Duration(milliseconds: 100));
    if (TelegramSDK.isTelegramWebApp) {
      print('Running in Telegram WebApp');
      TelegramSDK.initializeWebApp();
    } else {
      print('Running in browser');
    }
  }

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyALsi8csiwlaCUjDPHBmCScnZ3mzYN9q_c",
          authDomain: "dating-app-da7ee.firebaseapp.com",
          databaseURL: "https://dating-app-da7ee-default-rtdb.firebaseio.com",
          projectId: "dating-app-da7ee",
          storageBucket: "dating-app-da7ee.appspot.com",
          messagingSenderId: "449766472937",
          appId: "1:449766472937:web:ca1a6d1df997988f384478"
      )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb && TelegramSDK.isTelegramWebApp) {
      TelegramSDK.setupMainButton('Start Dating', () {
        print('Main button clicked');
        TelegramSDK.showAlert('Welcome to Dating App!');
      });
    }

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepo()),
        RepositoryProvider(create: (context) => StorageRepo()),
        RepositoryProvider(create: (context) => DatabaseRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(authRepo: context.read<AuthRepo>())
          ),
          BlocProvider(
            create: (context) => SwipeBloc()
              ..add(LoadUsers(
                users: User.users.where((user) => user.id != 1).toList(),
              )),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepo: context.read<AuthRepo>(),
            ),
          ),
          BlocProvider<RegistrationCubit>(
            create: (context) => RegistrationCubit(
              authRepo: context.read<AuthRepo>(),
            ),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              databaseRepository: context.read<DatabaseRepository>(),
              storageRepo: context.read<StorageRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) {
              final authBloc = context.read<AuthBloc>();
              final userId = authBloc.state.user?.uid;
              final profileBloc = ProfileBloc(
                authBloc: authBloc,
                databaseRepository: context.read<DatabaseRepository>(),
              );
              if (userId != null) {
                profileBloc.add(LoadProfile(userId: userId));
              }
              return profileBloc;
            },
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme().copyWith(
            brightness: TelegramSDK.isDarkTheme() ? Brightness.dark : Brightness.light,
          ),
          onGenerateRoute: AppRouter.onGenerateRote,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}