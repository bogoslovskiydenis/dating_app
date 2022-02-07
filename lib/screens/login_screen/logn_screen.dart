import 'package:dating_app/screens/home/widget/custom_app_bar.dart';
import 'package:dating_app/screens/login_screen/login_screens/bio_screen.dart';
import 'package:dating_app/screens/login_screen/login_screens/email_screen.dart';
import 'package:dating_app/screens/login_screen/login_screens/start_screen.dart';
import 'package:flutter/material.dart';

import 'login_screens/email_screen_verification.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => const LoginScreen(),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(text: 'Email'),
    Tab(text: 'Email Verification'),
    // Tab(text: 'Pictures'),
    // Tab(text: 'Biography'),
    // Tab(text: 'Location')
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: tabs.length,
        child: Builder(builder: (BuildContext context){
      final TabController tabController = DefaultTabController.of(context)!;
      tabController.addListener(() {
        if (!tabController.indexIsChanging) {}
      });
      return Scaffold(
        appBar: const CustomAppBar(title: 'Dating', action: false,),
        body: TabBarView(
          children: [
            Start(tabController: tabController),
            EmailScreen(tabController: tabController),
            EmailVerification(tabController: tabController),
          ],
        ),
      );
    }),
    );
  }
}
