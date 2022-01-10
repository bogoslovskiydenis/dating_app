import 'package:dating_app/model/models.dart';
import 'package:flutter/material.dart';

import 'widget/choice_button.dart';
import 'widget/custom_app_bar.dart';
import 'widget/user_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => HomeScreen(),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          UserCard(user: User.users[0],),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceButton(widht: 60, height: 60, size: 25, color: Theme.of(context).colorScheme.secondary, icon: Icons.clear_rounded ,),
                ChoiceButton(widht: 60, height: 60, size: 25, color: Theme.of(context).colorScheme.secondary, icon: Icons.favorite ,),
                ChoiceButton(widht: 60, height: 60, size: 25, color: Theme.of(context).colorScheme.secondary, icon: Icons.watch_later_outlined ,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
