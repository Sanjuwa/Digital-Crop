import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:digitalcrop/constants.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color? color;
  final Color? textColor;
  final bool enabled;

  const Button({super.key, required this.text, required this.onPressed, this.color, this.textColor, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: enabled ? color ?? kLightGreenColor : Color(0xffE5E5E5),
          padding: EdgeInsets.all(15.h),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: enabled ? textColor ?? kBackgroundColor : Color(0xff9E9E9E),
            fontSize: 25.sp,
            fontWeight: FontWeight.w600
        ),
      ),
      onPressed: () {
        if (enabled){
          onPressed();
        }
      },
    );
  }
}
