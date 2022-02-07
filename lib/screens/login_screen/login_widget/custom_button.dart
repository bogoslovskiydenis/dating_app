import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
          ),
        ),

        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0, primary: Colors.transparent),
            onPressed: () {},
            child:  Container(
                width: double.infinity,
                child: Center(child: Text('START')))));
  }
}
