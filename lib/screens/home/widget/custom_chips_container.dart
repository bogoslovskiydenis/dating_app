import 'package:dating_app/model/user_model.dart';
import 'package:flutter/material.dart';

class CustomChipsContainer extends StatelessWidget {
  const CustomChipsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = User.users[0];
    return Row(
      children: user.interests
          .map(
            (interest) => Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: LinearGradient(colors: [
                    Colors.red, Colors.blue
                  ])),
              child: Text(
                interest,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            ),
          )
          .toList(),
    );
  }
}
