import 'package:dating_app/home/home_screen.dart';
import 'package:dating_app/user_screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class AppRouter {
  static Route? onGenerateRote(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    switch (settings.name){
      case '/':
        return HomeScreen.route();
      case UsersScreen.routeName:
        return UsersScreen.route();
      default:
        return _errorRoute();
    }

  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: Text('error'))),
      settings: RouteSettings(name: '/error'),);
  }
}