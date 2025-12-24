import 'package:dating_app/screens/home/widget/custom_app_bar.dart';
import 'package:dating_app/screens/login_screen/login_screens/login.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.initialIndex = 0}) : super(key: key);
  static const String routeName = '/login';
  final int initialIndex;

  static Route route({int initialIndex = 0}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => LoginScreen(initialIndex: initialIndex),
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
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: LoginScreen.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Dating',
        action: false,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Start(tabController: _tabController),
          EmailScreen(tabController: _tabController),
          Location(tabController: _tabController),
          GenderScreen(tabController: _tabController),
          PictureScreen(tabController: _tabController),
          BiographyScreen(tabController: _tabController),
        ],
      ),
    );
  }

}
