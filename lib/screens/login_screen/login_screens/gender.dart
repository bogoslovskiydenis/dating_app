import 'package:dating_app/bloc/blocks.dart';
import 'package:dating_app/screens/login_screen/login_widget/custom_checkbox.dart';
import 'package:dating_app/screens/login_screen/login_widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../login_widget/custom_button.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({Key? key, required this.tabController}) : super(key: key);
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
                    'What\' your Gender?',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  CustomCheckbox(
                    text: 'Male',
                    value: state.user.gender == 'Male',
                    onChanged: (bool? newValue) {
                      context.read<LoginBloc>().add(
                            UpdateUserLogin(
                              user: state.user.copyWith(gender: 'Male'),
                            ),
                          );
                    },
                  ),
                  CustomCheckbox(
                    text: 'Female',
                    value: state.user.gender == 'Female',
                    onChanged: (bool? newValue) {
                      context.read<LoginBloc>().add(
                            UpdateUserLogin(
                              user: state.user.copyWith(gender: 'Female'),
                            ),
                          );
                    },
                  ),
                  Text(
                    'What\' your Age?',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  CustomTextField(
                    hint: 'Enter your Age',
                    onChanged: (value) {
                      context.read<LoginBloc>().add(
                            UpdateUserLogin(
                              user: state.user.copyWith(
                                age: int.parse(value),
                              ),
                            ),
                          );
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  const StepProgressIndicator(totalSteps: 6, currentStep: 3,
                    selectedColor: Colors.red,
                    unselectedColor: Colors.blue,),
                  const SizedBox(height: 20,),
                  CustomButton(
                    tabController: tabController,
                    text: 'Enter your Gender to Next Step',
                  ),
                ],
              )


            ],
          );
        } else {
          return const Text('Something wrong');
        }
      }),
    );
  }
}
