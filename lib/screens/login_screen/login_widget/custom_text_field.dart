import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key,  this.controller,  required this.hint, this.onChanged })
      : super(key: key);
  final TextEditingController? controller;
  final String hint;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8.0),),
        ), focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(8.0),),),),
      onChanged: onChanged,
    );
  }
}
