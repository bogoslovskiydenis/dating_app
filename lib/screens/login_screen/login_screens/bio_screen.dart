import 'package:dating_app/screens/home/widget/custom_chips_container.dart';
import 'package:dating_app/screens/login_screen/login_widget/custom_button.dart';
import 'package:flutter/material.dart';

import '../login_widget/custom_text_field.dart';

class BiographyScreen extends StatelessWidget {
  const BiographyScreen({Key? key, required this.tabController})
      : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50, right: 20, left:20),
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
                  tabController: tabController,
                  hint: 'Enter your bio',
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
          CustomButton(
            tabController: tabController,
            text: 'Enter Bio to Next Step',
          )
        ],
      ),
    );
  }
}
