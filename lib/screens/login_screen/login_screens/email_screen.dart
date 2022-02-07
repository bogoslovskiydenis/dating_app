import 'package:dating_app/screens/login_screen/login_widget/custom_button.dart';
import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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
              CustomTextField(tabController: tabController, hint: 'Write yor mail here',),
            ],
          ),
          CustomButton(
            tabController: tabController,
            text: 'Enter your Mail to Next Step',
          )
        ],
      ),
    );
  }
}
