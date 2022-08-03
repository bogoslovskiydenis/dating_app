import 'package:dating_app/cubit/signup_cubit.dart';
import 'package:dating_app/screens/login_screen/login_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../login_widget/custom_text_field.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
  builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What\' Your Email Address?',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 10,),
               CustomTextField( hint: 'Write yor email here',
                   onChanged: (value){
                     context.read<SignupCubit>().emailChanged(value);
                     print(state.email);
                   }
               ),
              Text(
                'What\' Your Password',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
                const SizedBox(height: 10,),
                CustomTextField( hint: 'Write yor password here',
                    onChanged: (value){
                  context.read<SignupCubit>().passwordChanged(value);
                  print(state.password);
                }),
            ],
          ),
          Column(
            children: [
              const StepProgressIndicator(totalSteps: 6, currentStep: 1,
                selectedColor: Colors.red,
                unselectedColor: Colors.blue,),
              const SizedBox(height: 20,),
              CustomButton(
                tabController: tabController,
                text: 'Enter your Mail to Next Step',

              ),
            ],
          ),
        ],
      ),
    );
  },
);
  }
}
