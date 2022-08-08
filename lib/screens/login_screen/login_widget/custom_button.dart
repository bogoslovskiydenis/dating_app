import 'package:dating_app/bloc/blocks.dart';
import 'package:dating_app/cubit/signup_cubit.dart';
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
            ElevatedButton.styleFrom(elevation: 0, primary: Colors.transparent),
        onPressed: () async {
          if (tabController.index == 5){
            Navigator.pushNamed(context, '/');
          } else {
            tabController.animateTo(tabController.index +1);
          }
          if (tabController.index == 2) {
            await context.read<SignupCubit>().signupCredential();

            User user = User(
              id: context.read<SignupCubit>().state.user!.uid,
              location: '',
              imageUrls:  [],
              interests:  [],
              jobTitle: '',
              gender: '',
              age: 0,
              bio: '',
              name: '',
            );
            context.read<LoginBloc>().add(StartLogin(user: user),);
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
