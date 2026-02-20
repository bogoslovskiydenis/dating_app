import 'package:dating_app/bloc/auth_bloc/auth_bloc.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated && context.mounted) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }
      },
      child: BlocListener<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
          if (state.status == RegistrationStatus.error && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Неверный email или пароль'),
                backgroundColor: Colors.red,
              ),
            );
            context.read<RegistrationCubit>().emailChanged(state.email);
          }
        },
        child: Scaffold(
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
              beginColor: Theme.of(context).colorScheme.secondary,
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
              beginColor: Theme.of(context).colorScheme.secondary,
              endColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () =>
                  Navigator.of(context).pushReplacement(
                    LoginScreen.route(initialIndex: 1),
                  ),
            ),
          ],
        ),
      ),
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
