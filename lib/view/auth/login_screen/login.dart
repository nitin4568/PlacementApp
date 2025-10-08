import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/Images/images.dart'; // Your login image
import 'package:placement/resource/components/buttons_components/black_continue_buttons.dart';
import 'package:placement/resource/components/social_login/social.dart'; // Social login buttons
import 'package:placement/resource/components/text_feild/CustomTextField.dart';
import 'package:placement/resource/routes/routs.dart';
import 'package:placement/view_models/controller/auth_controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.find<LoginController>(); // Using Get.find

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.h),

                // Top Image
                Center(
                  child: Image.asset(
                    AppAssets.login,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 20.h),

                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Login to continue",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),

                SizedBox(height: 30.h),

                // Social Login Buttons
                SocialAccountsHelper(),

                SizedBox(height: 30.h),

                // Email TextField
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'Enter your email',
                  obscureText: false,
                ),
                SizedBox(height: 16.h),

                // Password TextField
                CustomTextField(
                  controller: controller.passwordController,
                  hintText: 'Enter your password',
                  obscureText: true,
                ),

                SizedBox(height: 5.h),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                ),

                SizedBox(height: 20.h),

                // Login Button with Loader
                Obx(() => BlackContinueButton(
                  title: "Login",
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.login();
                  },
                )),

                SizedBox(height: 20.h),

                // Signup Redirect
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRouteNames.signup);
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
