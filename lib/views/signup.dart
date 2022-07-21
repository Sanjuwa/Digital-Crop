import 'package:digitalcrop/constants.dart';
import 'package:digitalcrop/controller/user_controller.dart';
import 'package:digitalcrop/views/home.dart';
import 'package:digitalcrop/widgets/button.dart';
import 'package:digitalcrop/widgets/input_filed.dart';
import 'package:digitalcrop/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

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
                controller: name,
              ),
              SizedBox(
                height: 11.h,
              ),
              InputFiled(
                text: 'Email',
                keyboard: TextInputType.emailAddress,
                icon: Icons.email_outlined,
                controller: email,
              ),
              SizedBox(
                height: 11.h,
              ),
              InputFiled(
                text: 'Password',
                isPassword: true,
                controller: password,
              ),
              SizedBox(
                height: 11.h,
              ),
              InputFiled(
                text: 'Confirm Password',
                isPassword: true,
                controller: confirmPassword,
              ),
              SizedBox(
                height: 55.h,
              ),

              //signup button
              SizedBox(
                width: double.infinity,
                child: Button(
                  text: 'Signup',
                  onPressed: () async {
                    if (name.text.trim().isEmpty ||
                        email.text.trim().isEmpty ||
                        password.text.trim().isEmpty) {
                      ToastBar(
                          text: 'Please fill all the fields!',
                          color: Colors.red)
                          .show();
                    } else if (password.text != confirmPassword.text) {
                      ToastBar(
                          text: 'Password does not match',
                          color: Colors.red)
                          .show();
                    } else {
                      ToastBar(
                          text: 'Please wait...',
                          color: Colors.orange)
                          .show();

                      bool isUserSignedUp =
                          await Provider.of<UserController>(context,
                          listen: false)
                          .signUp(
                          email.text.trim(),
                          password.text.trim(),
                          name.text.trim());

                      if (isUserSignedUp) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Home()),
                                (Route<dynamic> route) => false);
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 50.h,
              ),

              //log in
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: RichText(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
