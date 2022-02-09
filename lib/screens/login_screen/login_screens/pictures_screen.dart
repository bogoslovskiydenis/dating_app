import 'package:dating_app/screens/login_screen/login_widget/custom_button.dart';
import 'package:dating_app/screens/login_screen/login_widget/custom_image_container.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PictureScreen extends StatelessWidget {
  const PictureScreen({Key? key, required this.tabController})
      : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add 2 or more Pictures', style: Theme.of(context)
                      .textTheme.headline1!.copyWith(fontWeight: FontWeight.normal),
                  ),
                  Row(children: [
                    CustomImageContainer(tabController: tabController,),
                    CustomImageContainer(tabController: tabController,),
                    CustomImageContainer(tabController: tabController,),
                  ],),
                  Row(children: [
                    CustomImageContainer(tabController: tabController,),
                    CustomImageContainer(tabController: tabController,),
                    CustomImageContainer(tabController: tabController,),
                  ],),
                  ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
              child: Column(
                children: [
                  const StepProgressIndicator(totalSteps: 6, currentStep: 5,
                    selectedColor: Colors.red,
                    unselectedColor: Colors.blue,),
                  SizedBox(height: 20,),
                  CustomButton(
                    tabController: tabController,
                    text: 'Choice Photo to Next Step',
                  ),
                ],
              ),
            ),
          ],
         );
  }
}
