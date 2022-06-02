import 'package:dating_app/bloc/blocks.dart';
import 'package:dating_app/cubit/signup_cubit.dart';
import 'package:dating_app/repository/auth/auth_repo.dart';
import 'package:dating_app/repository/database/db_repository.dart';
import 'package:dating_app/repository/repositories.dart';
import 'package:dating_app/screens/home/widget/custom_app_bar.dart';
import 'package:dating_app/screens/login_screen/login_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SignupCubit(authRepo: context.read<AuthRepo>()),
            child: const LoginScreen(),
          ),
          BlocProvider<LoginBloc>(
            create: (_) => LoginBloc(
              databaseRepository: DatabaseRepository(),
              storageRepo: StorageRepo(),
            )..add(
                StartLogin(),
              ),
          )
        ],
        child: LoginScreen(),
      ),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(text: 'Email'),
    Tab(text: 'Location'),
    Tab(text: 'Gender'),
    Tab(text: 'Picture'),
    Tab(text: 'Biography')
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Dating',
            action: false,
          ),
          body: TabBarView(
            children: [
              Start(tabController: tabController),
              EmailScreen(tabController: tabController),
              Location(tabController: tabController),
              GenderScreen(tabController: tabController),
              PictureScreen(tabController: tabController),
              BiographyScreen(tabController: tabController),
            ],
          ),
        );
      }),
    );
  }
}
