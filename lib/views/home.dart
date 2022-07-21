import 'package:digitalcrop/constants.dart';
import 'package:digitalcrop/controller/image_controller.dart';
import 'package:digitalcrop/controller/user_controller.dart';
import 'package:digitalcrop/views/login.dart';
import 'package:digitalcrop/widgets/button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserController>(context);
    var imageController = Provider.of<ImageController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (await userController.signOut()) {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false);
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 30.h),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 35.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: GestureDetector(
                    onTap: () => imageController.pickImage(),
                    child: imageController.image == null
                        ? DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(20.r),
                            color: kBackgroundColor,
                            strokeWidth: 1.5,
                            dashPattern: [6, 10],
                            child: Column(
                              children: [
                                SizedBox(width: double.infinity),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25.h),
                                  child: Image.asset(
                                    "assets/camera.png",
                                    scale: 7,
                                    opacity: AlwaysStoppedAnimation<double>(0.3),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "Tap to take a photo",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                    color: kBackgroundColor,
                                  ),
                                ),
                                SizedBox(height: 15.h)
                              ],
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image.file(imageController.image!),
                          ),
                  ),
                ),
                SizedBox(height: 40.h),

                //instruction
                Card(
                  color: Color(0xffFAFAFA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  elevation: 7,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(left: Radius.circular(20.r)),
                            color: kGreenColor,
                          ),
                          width: 20.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 15.w, top: 15.h),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(10.w, 5.h, 0, 5.h),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 2, color: kGreenColor),
                                        borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 20,
                                          color: kBackgroundColor,
                                        ),
                                        dropdownColor: Colors.white,
                                        isDense: true,
                                        value: imageController.language,
                                        items: instructions.keys.map((key) => DropdownMenuItem(
                                          value: key,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 5.w),
                                            child: Text(
                                              key,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: kBackgroundColor,
                                              ),
                                            ),
                                          ),
                                        ),).toList(),
                                        onChanged: (value) => imageController.language = value as String,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.w, top: 15.h),
                                child: Text(
                                  "1. ${instructions[imageController.language]!['1']}",
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22.sp),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 35.w),
                                child: Text(
                                  instructions[imageController.language]!['1-1'].toString(),
                                  style: TextStyle(
                                      height: 1.1,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14.sp),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset("assets/instruction_img.png"),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.w, top: 20.h),
                                child: Text(
                                  "2. ${instructions[imageController.language]!['2']}",
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 85.h),

                //upload button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: Button(
                      text: "Upload",
                      enabled: imageController.image != null,
                      onPressed: () => imageController.uploadImage(context),
                      color: kGreenColor,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
