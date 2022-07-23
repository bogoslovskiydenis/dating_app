import 'package:dating_app/screens/login_screen/login_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../bloc/blocks.dart';
import '../login_widget/custom_image_container.dart';

class PictureScreen extends StatelessWidget {
  const PictureScreen({Key? key, required this.tabController})
      : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoginLoaded) {
          var images = state.user.imageUrls;
          var imageCount = images.length;
          return SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only( right: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add 2 or more Pictures',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        //TODO : not download photo to firebase ....
                        SizedBox(
                          height: 350,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 0.66),
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int index) {
                              return (imageCount > index)
                                  ? CustomImageContainer(
                                      imageUrls: images[index],
                                    )
                                  : const CustomImageContainer();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                               top: 90),
                          child: Column(
                            children: [
                              const StepProgressIndicator(
                                totalSteps: 6,
                                currentStep: 5,
                                selectedColor: Colors.red,
                                unselectedColor: Colors.blue,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                tabController: tabController,
                                text: 'Choice Photo to Next Step',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          );
        } else {
          return const Text('Something Wrong');
        }
      },
    );
  }
}
