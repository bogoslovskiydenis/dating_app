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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoginLoaded) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add 2 or more Pictures',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 400,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.66),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return (state.user.imageUrls.length > index)
                            ? CustomImageContainer(
                                imageUrls: state.user.imageUrls[index],
                              )
                            : const CustomImageContainer();
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  const StepProgressIndicator(
                    totalSteps: 6,
                    currentStep: 5,
                    selectedColor: Colors.red,
                    unselectedColor: Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    tabController: tabController,
                    text: 'Choice Photo to Next Step',
                  ),
                ],
              ),
            );
          } else {
            return const Text('Something Wrong');
          }
        },
      ),
    );
  }
}
