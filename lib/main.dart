import 'package:dating_app/bloc/swipe_bloc.dart';
import 'package:dating_app/model/models.dart';
import 'package:dating_app/routing/app_routing.dart';
import 'package:dating_app/screens/login_screen/logn_screen.dart';
import 'package:dating_app/screens/profile_screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/home/home_screen.dart';
import 'screens/match_screen/match_screen.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => SwipeBloc()..add(LoadUsersEvent(users: User.users)))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRote,
        initialRoute: LoginScreen.routeName,
      ),
    );
  }
}