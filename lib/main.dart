import 'package:dating_app/model/models.dart';
import 'package:dating_app/routing/app_routing.dart';
import 'package:dating_app/screens/login_screen/logn_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/blocks.dart';
import 'repository/repositories.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepo(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AuthBloc(authRepo: context.read<AuthRepo>())),
          BlocProvider(
            create: (_) => SwipeBloc()
              ..add(
                LoadUsersEvent(
                  users: User.users.where((user) => user.id != 1).toList(),
                ),
              ),
          ),
          BlocProvider(
              create: (_) =>
                  ImagesBloc(databaseRepository: DatabaseRepository())
                    ..add(
                      LoadImages(),
                    ))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRote,
          initialRoute: LoginScreen.routeName,
        ),
      ),
    );
  }
}
