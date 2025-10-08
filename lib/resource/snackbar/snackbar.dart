import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  // Show a snackbar with a title and message
  static void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.7),
      colorText: Colors.white,
      borderRadius: 8.0,
      margin: const EdgeInsets.all(12.0),
      duration: const Duration(seconds: 3),
    );
  }
}
