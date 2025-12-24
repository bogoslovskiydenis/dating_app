import 'package:dating_app/screens/chat_screen/chat.dart';
import 'package:dating_app/screens/home/home_screen.dart';
import 'package:dating_app/screens/login_screen/logn_screen.dart';
import 'package:dating_app/screens/login_screen/registration_screen.dart';
import 'package:dating_app/screens/match_screen/match_screen.dart';
import 'package:dating_app/screens/profile_screen/profile.dart';
import 'package:dating_app/screens/splash_scren/splash_screen.dart';
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
        final args = settings.arguments as Map<String, dynamic>;
        return ChatScreen.route(
          chatId: args['chatId'] as String,
          matchedUser: args['matchedUser'] as User,
        );
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case LoginScreen.routeName:
        final initialIndex = settings.arguments as int? ?? 0;
        return LoginScreen.route(initialIndex: initialIndex);
      case RegistrationScreen.routeName:
        return RegistrationScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: const Text('error'))),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
