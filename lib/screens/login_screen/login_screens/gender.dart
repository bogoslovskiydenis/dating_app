import 'package:dating_app/screens/login_screen/login_widget/custom_button.dart';
import 'package:dating_app/screens/login_screen/login_widget/custom_checkbox.dart';
import 'package:dating_app/screens/login_screen/login_widget/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({
    Key? key,
    required this.tabController,
  }) : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20,right: 20,left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What\' your Gender?',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              CustomCheckbox(
                tabController: tabController,
                text: 'Male',
              ),
              CustomCheckbox(
                tabController: tabController,
                text: 'Female',
              ),
              Text(
                'What\' your Age?',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              CustomTextField(
                hint: 'Enter your Age',
                tabController: tabController,
              ),
            ],
          ),
          Column(
            children: [
              const StepProgressIndicator(totalSteps: 6, currentStep: 4,
                selectedColor: Colors.red,
                unselectedColor: Colors.blue,),
              SizedBox(height: 20,),
              CustomButton(
                tabController: tabController,
                text: 'Enter your Gender and Age to Next Step',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
