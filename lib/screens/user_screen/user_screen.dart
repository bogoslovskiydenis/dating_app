import 'package:dating_app/model/models.dart';
import 'package:flutter/material.dart';

import '../home/widget/home.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  static const String routeName = '/users';

  static Route route({required User user}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => UsersScreen(user: user),
    );
  }

  final User user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Hero(
                      tag: 'user_image',
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                              image: NetworkImage(user.imageUrls[0]),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ChoiceButton(
                            color: Theme.of(context).colorScheme.secondary,
                            icon: Icons.clear_rounded,
                          ),
                          ChoiceButton(
                            color: Theme.of(context).colorScheme.secondary,
                            icon: Icons.favorite,
                          ),
                          ChoiceButton(
                            color: Theme.of(context).colorScheme.secondary,
                            icon: Icons.watch_later_outlined,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.name} , ${user.age}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    '${user.jobTitle} ',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    '${user.bio} ',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.normal,
                          height: 2,
                        ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Interests',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  /*make create chips */
                  const CustomChipsContainer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
