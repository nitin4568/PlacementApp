import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/Images/images.dart';
import 'package:placement/resource/components/buttons_components/black_continue_buttons.dart';
import 'package:placement/resource/components/text_feild/CustomTextField.dart';
import 'package:placement/view_models/controller/auth_controller/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  AppAssets.signup,
                  width: 350.w,
                  height: 240.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  "Create Account",
                  style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  "Join now to access placement resources",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(controller: controller.fullNameController, hintText: "Full Name"),
                      SizedBox(height: 15.h),
                      CustomTextField(controller: controller.emailController, hintText: "Email"),
                      SizedBox(height: 15.h),
                      CustomTextField(controller: controller.passwordController, hintText: "Password", obscureText: true),
                      SizedBox(height: 15.h),
                      CustomTextField(controller: controller.confirmPasswordController, hintText: "Confirm Password", obscureText: true),
                      SizedBox(height: 15.h),
                      CustomTextField(controller: controller.collegeController, hintText: "College / University Name"),
                      SizedBox(height: 15.h),
                      CustomTextField(controller: controller.branchController, hintText: "Branch / Department"),
                      SizedBox(height: 15.h),
                      CustomTextField(controller: controller.courseController, hintText: "Course / Degree"),
                      SizedBox(height: 15.h),
                      CustomTextField(controller: controller.rollNoController, hintText: "University Roll No."),
                      SizedBox(height: 15.h),
                      CustomTextField(controller: controller.phoneController, hintText: "Phone Number"),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
              Obx(() => BlackContinueButton(
                title: "Sign Up",
                isLoading: controller.isLoading.value,
                onPressed: controller.signup,
              )),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
