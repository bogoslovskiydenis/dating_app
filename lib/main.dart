import 'package:dating_app/home/home_screen.dart';
import 'package:dating_app/user_screen/user_screen.dart';
import 'package:flutter/material.dart';

import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home:  UsersScreen(),
    );
  }
}
