import 'package:dating_app/screens/login_screen/login_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../bloc/login/login_bloc.dart';
import '../login_widget/custom_text_field.dart';

class Location extends StatelessWidget {
  const Location({Key? key, required this.tabController})
      : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 50),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if(state is LoginLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state is LoginLoaded){

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'What\' Your Location?',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  CustomTextField(
                    hint: 'Enter your Location',
                    onChanged: (value) {
                      context.read<LoginBloc>().add(
                        UpdateUserLogin(
                          user: state.user.copyWith(
                            location: (value),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  const StepProgressIndicator(totalSteps: 6, currentStep: 2,
                    selectedColor: Colors.red,
                    unselectedColor: Colors.blue,),
                  const SizedBox(height: 20,),
                  CustomButton(
                    tabController: tabController,
                    text: 'Enter your Location to Next Step',
                  ),
                ],
              )
            ],
          );
          }else {return const Text('Something Wrong');}
        },
      ),
    );
  }
}
