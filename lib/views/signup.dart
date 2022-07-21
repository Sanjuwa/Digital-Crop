import 'package:digitalcrop/constants.dart';
import 'package:digitalcrop/widgets/button.dart';
import 'package:digitalcrop/widgets/input_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 45.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),

              //logo
              Center(
                child: Image.asset('assets/logo.png'),
              ),

              //heading
              Padding(
                padding: EdgeInsets.only(bottom: 35.h, top: 70.h),
                child: Text(
                  'Signup Details',
                  style: GoogleFonts.sourceSansPro(
                    fontSize: 40.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              //text fields
              InputFiled(
                text: 'Name',
              ),
              SizedBox(
                height: 11.h,
              ),
              InputFiled(
                text: 'Email',
                keyboard: TextInputType.emailAddress,
                icon: Icons.email_outlined,
              ),
              SizedBox(
                height: 11.h,
              ),
              InputFiled(
                text: 'Password',
                isPassword: true,
              ),
              SizedBox(
                height: 11.h,
              ),
              InputFiled(
                text: 'Confirm Password',
                isPassword: true,
              ),
              SizedBox(
                height: 55.h,
              ),

              //login button
              SizedBox(
                width: double.infinity,
                child: Button(
                  text: 'Signup',
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 50.h,
              ),

              //sign up
              RichText(
                text: TextSpan(
                    text: 'Do you have an account?  ',
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login',
                        style: GoogleFonts.outfit(
                          decoration: TextDecoration.underline,
                          color: kLightGreenColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
