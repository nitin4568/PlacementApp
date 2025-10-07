import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement/resource/routes/app_routes.dart';
import 'package:placement/resource/routes/routs.dart';

class EmailVerificationController extends GetxController {
  final otpController = TextEditingController();
  var isLoading = false.obs;

  void verifyOtp() {
    if (otpController.text.trim().length != 5) {
      Get.snackbar("Error", "Enter valid 5-digit OTP", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      Get.offAllNamed(AppRouteNames.home);
      Get.snackbar("Success", "Email Verified Successfully", snackPosition: SnackPosition.BOTTOM);
    });
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
