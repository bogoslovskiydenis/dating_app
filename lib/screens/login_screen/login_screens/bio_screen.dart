import 'package:dating_app/screens/home/widget/home.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../login_widget/custom_button.dart';
import '../login_widget/custom_text_field.dart';

class BiographyScreen extends StatelessWidget {
  const BiographyScreen({Key? key, required this.tabController})
      : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final controller =  TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20,right: 20,left: 20),
      child: Column(
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
                hint: 'Enter your bio',
                controller: controller,
                ),
              Text(
                'What Do Dou like?',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              CustomChipsContainer(),
            ],
          ),
          Column(
            children: [
              const StepProgressIndicator(totalSteps: 6, currentStep: 6,
                selectedColor: Colors.red,
                unselectedColor: Colors.blue,),
              SizedBox(height: 20,),
              CustomButton(
                tabController: tabController,
                text: 'Enter Bio to Next Step',
              ),
            ],
          )
        ],
      ),
    );
  }
}
