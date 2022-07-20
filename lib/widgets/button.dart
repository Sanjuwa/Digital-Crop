import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:digitalcrop/constants.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;

  const Button({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: kGreenColor,
          padding: EdgeInsets.all(15.h)
      ),
      child: Text(
        text,
        style: TextStyle(
            color: kBackgroundColor,
            fontSize: 25.sp,
            fontWeight: FontWeight.w600
        ),
      ),
      onPressed: () => onPressed(),
    );
  }
}
