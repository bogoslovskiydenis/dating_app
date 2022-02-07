import 'package:dating_app/screens/login_screen/login_widget/custom_button.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  const Start({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(image: AssetImage('assets/logo.jpg'), fit: BoxFit.cover)),
             width: 200,
             height: 300,
            // child: Image.asset('assets/logo.jpg'),
          ),
          Text(
              'Welcome to Dating App',
              style: Theme.of(context).textTheme.headline2,
          ),
          Text('App Description'),
          CustomButton(tabController: tabController),
        ],
      ),
    );
  }
}
