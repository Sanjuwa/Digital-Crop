import 'package:flutter/material.dart';
import 'package:digitalcrop/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputFiled extends StatefulWidget {
  final String text;
  final bool isPassword;
  final IconData? icon;

  const InputFiled({super.key, required this.text, this.isPassword = false, this.icon});

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
      style: TextStyle(
        color: Colors.white,
      ),
      obscureText: hideText,
      cursorColor: kGreenColor,
      decoration: InputDecoration(
        hintText: widget.text,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: kGreenColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: kGreenColor,
            width: 2,
          ),
        ),
        suffixIcon: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(
            widget.isPassword
                ? hideText
                    ? Icons.visibility
                    : Icons.visibility_off
                : widget.icon,
            color: Colors.white,
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
