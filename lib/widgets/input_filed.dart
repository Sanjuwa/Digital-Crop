import 'package:flutter/material.dart';
import 'package:digitalcrop/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputFiled extends StatefulWidget {
  final String text;
  final bool isPassword;
  final IconData? icon;
  final TextInputType? keyboard;
  final TextEditingController controller;

  const InputFiled({super.key, required this.text, this.isPassword = false, this.icon, this.keyboard, required this.controller});

  @override
  State<InputFiled> createState() => _InputFiledState();
}

class _InputFiledState extends State<InputFiled> {
  bool hideText = false;

  @override
  void initState() {
    super.initState();
    hideText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: TextStyle(
        color: Colors.white,
      ),
      keyboardType: widget.keyboard,
      obscureText: hideText,
      cursorColor: kLightGreenColor,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.text,
        hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: kLightGreenColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: kLightGreenColor,
            width: 2,
          ),
        ),
        suffixIcon: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(
            widget.isPassword
                ? hideText
                    ? Icons.visibility_off
                    : Icons.visibility
                : widget.icon,
            color: Colors.white,
            size: 22,
          ),
          onPressed: () {
            if (widget.isPassword) {
              setState((){
                hideText = !hideText;
              });
            }
          },
        ),
      ),
    );
  }
}
