import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key,
      required this.text,
      required this.beginColor,
      required this.endColor,
      required this.textColor,
      this.onPressed})
      : super(key: key);

  final String text;
  final Color beginColor;
  final Color endColor;
  final Color textColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withAlpha(50),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(2, 2),
          )
        ],
        gradient: const LinearGradient(
          colors: [Colors.red, Colors.blue],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            fixedSize: Size(200, 40)),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
