import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/components/buttons_components/black_continue_buttons.dart';
import 'package:placement/view_models/controller/auth_controller/email_varification_contoller.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmailVerificationController());
    final args = Get.arguments as Map<String, dynamic>?;

    final fullName = args?['fullName'] ?? "";
    final email = args?['email'] ?? "";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verify your Email",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Text(
              "We have sent a verification link to $email. Please check your inbox.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              "If you don’t see the email in your inbox, check the Spam/Promotions folder and mark it as Not Spam.",
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            Obx(() => BlackContinueButton(
              title: "I have Verified",
              isLoading: controller.isLoading.value,
              onPressed: () => controller.checkEmailVerified(fullName),
            )),
          ],
        ),
      ),
    );
  }
}
