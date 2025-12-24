import 'package:flutter/material.dart';

class UserImageSmall extends StatelessWidget {
  const UserImageSmall({Key? key, required this.url, this.height=50, this.width=50,}) : super(key: key);

  final String url;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isEmpty = url.isEmpty || url == 'https://via.placeholder.com/150';
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 8),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          image: !isEmpty
              ? DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)
              : null,
          borderRadius: BorderRadius.circular(5.0)),
      child: isEmpty
          ? Icon(Icons.person, size: height * 0.5, color: Colors.grey[600])
          : null,
    );
  }
}