import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/components/buttons_components/black_continue_buttons.dart';
import 'package:placement/resource/components/social_login/otp_box.dart';
import 'package:placement/view_models/controller/auth_controller/email_varification_contoller.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmailVerificationController>();
    final email = Get.arguments ?? "yourmail@email.com";

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            Text("Verify your email", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),
            Text("Enter the 5-digit OTP sent to\n$email", textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
            SizedBox(height: 24.h),

            OTPBox(
              onChanged: (val) => controller.otpController.text = val,
              onCompleted: (val) => controller.otpController.text = val,
            ),

            SizedBox(height: 16.h),
            GestureDetector(onTap: () {}, child: Text("Resend Code", style: TextStyle(fontSize: 14.sp, color: Colors.blue))),

            const Spacer(),
            Obx(() => BlackContinueButton(
              width: double.infinity,
              height: 48.h,
              title: "Verify",
              isLoading: controller.isLoading.value,
              onPressed: controller.verifyOtp,
            )),
          ],
        ),
      ),
    );
  }
}
