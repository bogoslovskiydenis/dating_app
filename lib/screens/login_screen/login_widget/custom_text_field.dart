import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.tabController,  required this.hint })
      : super(key: key);
  final TabController tabController;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return  TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        contentPadding: const EdgeInsets.only(
            left: 20, bottom: 5, right: 5, top: 5),
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8.0),),
        ), focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(8.0),),),),
    );
  }
}
