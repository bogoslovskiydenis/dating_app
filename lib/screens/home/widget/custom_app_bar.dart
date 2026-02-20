import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.title, this.action = true})
      : super(key: key);
  final String title;
  final bool action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/emblem.jpg',
              height: 60,
            ),
            const Spacer(),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 30,
                    color: const Color(0xFF282E4A),
                    fontWeight: FontWeight.bold,
                  ) ??
                  const TextStyle(
                    fontSize: 30,
                    color: Color(0xFF282E4A),
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
          ],
        ),
        actions: action
            ? [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/matches');
                    },
                    icon: Icon(
                      Icons.message,
                      color: Theme.of(context).primaryColor,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    icon: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    )),
              ]
            : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
