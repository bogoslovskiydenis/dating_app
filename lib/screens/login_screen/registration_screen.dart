import 'package:dating_app/bloc/blocks.dart';
import 'package:dating_app/cubit/registration/registration_cubit.dart';
import 'package:dating_app/screens/home/home_screen.dart';
import 'package:dating_app/screens/home/widget/home.dart';
import 'package:dating_app/screens/login_screen/logn_screen.dart';
import 'package:dating_app/screens/login_screen/registration_widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const String routeName = '/registration';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.authenticated
              ? const HomeScreen()
              : const RegistrationScreen();
        });
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
              onPressed: () {
                context.read<RegistrationCubit>().logInWithCredentials();
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
              text: 'SignUp',
              beginColor: Theme.of(context).accentColor,
              endColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () =>
                  Navigator.of(context).restorablePushNamedAndRemoveUntil(
                LoginScreen.routeName,
                ModalRoute.withName('/login'),
              ),
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
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<RegistrationCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(labelText: 'Email'),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<RegistrationCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        );
      },
    );
  }
}
