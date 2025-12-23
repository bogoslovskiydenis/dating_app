import 'package:flutter/material.dart';

class TitleWithIcon extends StatelessWidget {
  const TitleWithIcon({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
          onPressed: onPressed,  // Используем callback
          icon: Icon(icon),
        )
      ],
    );
  }
}