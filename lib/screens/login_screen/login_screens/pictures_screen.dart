import 'package:dating_app/screens/login_screen/login_widget/custom_button.dart';
import 'package:dating_app/screens/login_screen/login_widget/custom_image_container.dart';
import 'package:flutter/material.dart';

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
              padding: const EdgeInsets.only(right: 30,left: 30,bottom: 50),
              child: CustomButton(
                tabController: tabController,
                text: 'Choice Photo to Next Step',
              ),
            ),
          ],
         );
  }
}
