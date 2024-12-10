import 'package:dating_app/bloc/blocks.dart';
import 'package:dating_app/cubit/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/user_model.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key, required this.tabController, this.text = 'Start'})
      : super(key: key);
  final TabController tabController;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          colors: [Colors.red, Colors.blue],
        ),
      ),
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(elevation: 0, backgroundColor: Colors.transparent),
        onPressed: () async {
          if (tabController.index == 5) {
            Navigator.pushNamed(context, '/');
            return;
          }

          if (tabController.index == 1) { // Email секция
            try {
              await context.read<SignupCubit>().signupCredential();
              final signupState = context.read<SignupCubit>().state;

              if (signupState.status == SignupStatus.success && signupState.user != null) {
                final user = User(
                  id: signupState.user!.uid,
                  location: '',
                  imageUrls: [],
                  interests: [],
                  jobTitle: '',
                  gender: '',
                  age: 0,
                  bio: '',
                  name: '',
                );

                context.read<LoginBloc>().add(StartLogin(user: user));
                await Future.delayed(const Duration(milliseconds: 500));
                tabController.animateTo(tabController.index + 1);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please complete registration')),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${e.toString()}')),
              );
            }
          } else {
            tabController.animateTo(tabController.index + 1);
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
