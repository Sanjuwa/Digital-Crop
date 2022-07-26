import 'package:digitalcrop/constants.dart';
import 'package:digitalcrop/controller/image_controller.dart';
import 'package:digitalcrop/controller/user_controller.dart';
import 'package:digitalcrop/firebase_options.dart';
import 'package:digitalcrop/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      minTextAdapt: true,
      builder: (context, child) => MultiProvider(
        providers: [
          Provider<UserController>(create: (_) => UserController()),
          ChangeNotifierProvider<ImageController>(create: (_) => ImageController()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              textTheme: GoogleFonts.outfitTextTheme(),
              primaryColor: kBackgroundColor,
              appBarTheme: AppBarTheme(
                centerTitle: true,
                backgroundColor: kBackgroundColor,
                elevation: 0,
                titleTextStyle: GoogleFonts.sourceSansPro(
                  color: Colors.white,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w600,
                ),
              )),
          home: Wrapper(),
        ),
      ),
    );
  }
}
