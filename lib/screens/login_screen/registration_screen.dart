import 'package:dating_app/screens/home/widget/home.dart';
import 'package:dating_app/screens/login_screen/registration_widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const String routeName = '/registration';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const RegistrationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Dating',
        action: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailInput(),
            SizedBox(
              height: 10,
            ),
            PasswordInput(),
            SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
              text: 'Login',
              beginColor: Theme.of(context).accentColor,
              endColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {},
            ),
            SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
              text: 'SignUp',
              beginColor: Theme.of(context).accentColor,
              endColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (email) {},
      decoration: const InputDecoration(labelText: 'Email'),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (email) {},
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
    );
  }
}
