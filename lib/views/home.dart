import 'package:digitalcrop/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 10.h),
        child: Column(
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(20.r),
              color: kBackgroundColor,
              strokeWidth: 1.5,
              dashPattern: [6,9],
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.h),
                    child: Image.asset("assets/camera.png", scale: 7,opacity: AlwaysStoppedAnimation<double>(0.3),),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                      "Tap to take a photo",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Card(
              color: Color(0xffFAFAFA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              elevation: 7,
              child: IntrinsicHeight(
                child: Row(
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
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15.w, top: 15.h),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10.w,5.h,0,5.h),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 2, color: kGreenColor),
                                    borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    icon: Icon(Icons.keyboard_arrow_down_rounded,size: 20,color: kBackgroundColor,),
                                    dropdownColor: Colors.white,
                                    isDense: true,
                                    value: "Vietnamese",
                                    onChanged: (context){},
                                    items: [
                                      DropdownMenuItem(
                                        value: "English",
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 5.w),
                                          child: Text(
                                            "English",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kBackgroundColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "Vietnamese",
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 5.w),
                                          child: Text(
                                            "Vietnamese",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kBackgroundColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.w, top: 20.h),
                            child: Text(
                              "1. Take Photo of pipe in field",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22.sp
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35.w),
                            child: Text(
                              "During dry-down, ensure orange band is visible in photo",
                              style: TextStyle(
                                height: 1.1,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13.sp
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
