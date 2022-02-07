import 'package:dating_app/screens/login_screen/login_widget/custom_button.dart';
import 'package:flutter/material.dart';

import '../login_widget/custom_text_field.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({Key? key, required this.tabController}) : super(key: key);
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
                'Did you get the Verification Code?',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20),
                child: CustomTextField(tabController: tabController, hint: 'Write yor Verification Code',),
              ),
            ],
          ),
          CustomButton(
            tabController: tabController,
            text: 'Enter your Verification Code to Next Step',
          )
        ],
      ),
    );
  }
}
