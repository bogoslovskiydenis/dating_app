import 'package:dating_app/bloc/blocks.dart';
import 'package:dating_app/screens/home/widget/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../login_widget/custom_button.dart';
import '../login_widget/custom_text_field.dart';

class BiographyScreen extends StatelessWidget {
  const BiographyScreen({Key? key, required this.tabController})
      : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoginLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Describe Yourself',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    CustomTextField(
                      hint: 'Describe Yourself',
                      onChanged: (value) {
                        context.read<LoginBloc>().add(
                              UpdateUserLogin(
                                user: state.user.copyWith(
                                  bio: (value),
                                ),
                              ),
                            );
                      },
                    ),
                    Text(
                      'What Do Dou like?',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    const CustomChipsContainer(),
                  ],
                ),
                Column(
                  children: [
                    const StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 6,
                      selectedColor: Colors.red,
                      unselectedColor: Colors.blue,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      tabController: tabController,
                      text: 'Enter Bio to Next Step',
                    ),
                  ],
                )
              ],
            );
          } else {
            return const Text('Something Wrong');
          }
        },
      ),
    );
  }
}
