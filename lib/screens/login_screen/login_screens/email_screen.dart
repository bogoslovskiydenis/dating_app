import 'package:dating_app/screens/login_screen/login_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../login_widget/custom_text_field.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20,right: 20,left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'What\' Your Email Address?',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomTextField(tabController: tabController, hint: 'Write yor mail here',),
              ),
            ],
          ),
          Column(
            children: [
              const StepProgressIndicator(totalSteps: 6, currentStep: 1,
                selectedColor: Colors.red,
                unselectedColor: Colors.blue,),
              SizedBox(height: 20,),
              CustomButton(
                tabController: tabController,
                text: 'Enter your Mail to Next Step',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
