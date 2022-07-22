import 'package:digitalcrop/constants.dart';
import 'package:digitalcrop/controller/user_controller.dart';
import 'package:digitalcrop/views/home.dart';
import 'package:digitalcrop/views/signup.dart';
import 'package:digitalcrop/widgets/button.dart';
import 'package:digitalcrop/widgets/input_filed.dart';
import 'package:digitalcrop/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(40.w, 30.h, 40.w, 0.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),

              //logo
              Center(
                child: SizedBox(
                  width: 270.h,
                    child: Image.asset('assets/logo.png'),
                ),
              ),

              //heading
              Padding(
                padding: EdgeInsets.only(bottom: 30.h, top: 60.h),
                child: Text(
                  'Login Details',
                  style: GoogleFonts.sourceSansPro(
                    fontSize: 35.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              //text fields
              InputFiled(
                text: 'Email',
                icon: Icons.email_outlined,
                keyboard: TextInputType.emailAddress,
                controller: email,
              ),
              SizedBox(
                height: 11.h,
              ),
              InputFiled(
                text: 'Password',
                controller: password,
                isPassword: true,
              ),

              //forgot password
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25.w,25.h,0,25.h),
                  child: GestureDetector(
                    onTap: () async {
                      if (email.text.trim().isEmpty) {
                        ToastBar(text: 'Please fill email!', color: Colors.red).show();
                      } else {
                        ToastBar(text: 'Please wait...', color: Colors.orange).show();

                        bool success =
                        await Provider.of<UserController>(context, listen: false)
                            .forgetPassword(email.text.trim());
                        if (success) {
                          ToastBar(
                              text: 'Password reset link sent to your email! Check your inbox or spam folders.',
                              color: Colors.green)
                              .show();
                        }
                      }
                    },
                    child: Text(
                      'Forgot Password ?',
                      style:
                          TextStyle(color: kLightGreenColor, fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.w,
              ),

              //login button
              SizedBox(
                width: double.infinity,
                child: Button(
                  text: 'Login',
                  onPressed: () async {
                    if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
                      ToastBar(text: 'Please fill all the fields!', color: Colors.red)
                          .show();
                    } else {
                      ToastBar(text: 'Please wait...', color: Colors.orange).show();

                      bool isUserLoggedIn =
                          await Provider.of<UserController>(context, listen: false)
                          .signIn(email.text.trim(), password.text.trim());
                      if (isUserLoggedIn) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(builder: (context) => Home()),
                                (Route<dynamic> route) => false);
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 150.h,
              ),

              //sign up
              GestureDetector(
                onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => SignUp())),
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account?  ',
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          style: GoogleFonts.outfit(
                            decoration: TextDecoration.underline,
                            color: kLightGreenColor,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ]),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
