import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/components/buttons_components/simple_button.dart';
import 'package:placement/resource/routes/routs.dart';
import 'package:placement/view/home_page/resume_analyzer.dart';

class ResumeBuilderWidget extends StatelessWidget {
  const ResumeBuilderWidget({super.key});

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
                    "Build Your Resume",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Create a professional resume to impress recruiters.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                    text: "Build",
                    onPressed: () {
                      Get.toNamed(AppRouteNames.Resume);
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
              child: Icon(Icons.description, color: Colors.white, size: 30.w),
            ),
          ],
        ),
      ),
    );
  }
}
