import 'package:dating_app/bloc/images_bloc/images_bloc.dart';
import 'package:dating_app/screens/login_screen/login_widget/custom_button.dart';
import 'package:dating_app/screens/login_screen/login_widget/custom_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PictureScreen extends StatelessWidget {
  const PictureScreen({Key? key, required this.tabController})
      : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
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
              BlocBuilder<ImagesBloc, ImagesState>(
                builder: (context, state) {
                  if (state is ImagesLoading) {
                    return Center(
                      child: CustomImageContainer()
                    );
                  } else if (state is ImagesLoaded) {
                    var imageCount = state.imageUrls.length;
                    return SizedBox(
                      height: 300,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 0.66),
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return imageCount > index
                                ? CustomImageContainer(
                                    imageUrls: state.imageUrls[index],
                                  )
                                : CustomImageContainer();
                          }),
                    );
                  } else {
                    return Text('Wrong');
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
          child: Column(
            children: [
              const StepProgressIndicator(
                totalSteps: 6,
                currentStep: 5,
                selectedColor: Colors.red,
                unselectedColor: Colors.blue,
              ),
              SizedBox(
                height: 20,
              ),
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
