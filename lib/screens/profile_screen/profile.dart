import 'package:dating_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:dating_app/repository/auth/auth_repo.dart';
import 'package:dating_app/screens/login_screen/logn_screen.dart';
import 'package:dating_app/screens/profile_screen/widgets/title_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/models.dart';
import '../home/widget/home.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          print(BlocProvider.of<AuthBloc>(context).state.status);
          return (BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated)
              ? const LoginScreen()
              : const ProfileScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    final User user = User.users[0];
    return Scaffold(
      appBar: const CustomAppBar(title: "Profile"),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        spreadRadius: 3,
                      ),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(user.imageUrls[0]),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.1),
                        Theme.of(context).primaryColor.withOpacity(0.7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      user.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const TitleWithIcon(
                    title: 'Biography',
                    icon: Icons.edit,
                  ),
                  Text(user.bio,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(height: 1.5)),
                  const TitleWithIcon(
                    title: 'Picture',
                    icon: Icons.edit,
                  ),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 80,
                            width: 80,
                            padding: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(user.imageUrls[index]),
                              ),
                            ),
                          );
                        }),
                  ),
                  const TitleWithIcon(
                    title: 'Location!!',
                    icon: Icons.edit,
                  ),
                  Text('location',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(height: 1.5)),
                  const TitleWithIcon(
                    title: 'Interest',
                    icon: Icons.edit,
                  ),
                  const CustomChipsContainer(),
                  TextButton(
                      onPressed: () {
                        RepositoryProvider.of<AuthRepo>(context).signOut();
                      },
                      child: Center(
                        child: Text(
                          'Sign Out',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
