import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:digitalcrop/constants.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color ?color;
  final Color ?textColour;

  const Button({super.key, required this.text, required this.onPressed, this.color, this.textColour});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color ?? kLightGreenColor,
          padding: EdgeInsets.all(15.h)
      ),
      child: Text(
        text,
        style: TextStyle(
            color: textColour ?? kBackgroundColor,
            fontSize: 25.sp,
            fontWeight: FontWeight.w600
        ),
      ),
      onPressed: () => onPressed(),
    );
  }
}
