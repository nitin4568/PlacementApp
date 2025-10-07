import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/components/buttons_components/simple_button.dart';
import 'package:placement/resource/routes/routs.dart';

class LectureWidget extends StatelessWidget {
  const LectureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Improve Your Knowledge",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "By....",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                    text: "See the Lecture",
                    onPressed: () {
                      Get.toNamed(AppRouteNames.lecture);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.teal.shade700,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.video_collection, color: Colors.white, size: 30.sp),
            ),
          ],
        ),
      ),
    );
  }
}
