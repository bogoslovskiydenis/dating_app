import 'package:dating_app/screens/chat_screen/chat.dart';
import 'package:dating_app/screens/home/home_screen.dart';
import 'package:dating_app/screens/login_screen/logn_screen.dart';
import 'package:dating_app/screens/match_screen/match_screen.dart';
import 'package:dating_app/screens/profile_screen/profile.dart';
import 'package:dating_app/screens/user_screen/user_screen.dart';
import 'package:flutter/material.dart';

import '../model/models.dart';

class AppRouter {
  static Route? onGenerateRote(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case UsersScreen.routeName:
        return UsersScreen.route(user: settings.arguments as User);
      case MatchesScreen.routeName:
        return MatchesScreen.route();
      case ChatScreen.routeName:
        return ChatScreen.route(userMatch: settings.arguments as UserMatch);
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: Text('error'))),
      settings: RouteSettings(name: '/error'),
    );
  }
}
