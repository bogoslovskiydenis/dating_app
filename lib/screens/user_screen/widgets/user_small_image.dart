import 'package:flutter/material.dart';

class UserImageSmall extends StatelessWidget {
  const UserImageSmall({Key? key, required this.url, this.height=50, this.width=50,}) : super(key: key);

  final String url;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 8),
      height: height,
      width: width,
      decoration: BoxDecoration(
          image:
          DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(5.0)),
    );
  }
}