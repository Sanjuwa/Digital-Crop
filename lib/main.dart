import 'package:digitalcrop/constants.dart';
import 'package:digitalcrop/controller/user_controller.dart';
import 'package:digitalcrop/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      builder: (context, child) => MultiProvider(
        providers: [
          Provider<UserController>(create: (_) => UserController())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.outfitTextTheme(),
            primaryColor: kBackgroundColor,
          ),
          home: Login(),
        ),
      ),
    );
  }
}
