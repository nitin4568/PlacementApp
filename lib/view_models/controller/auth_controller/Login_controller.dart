import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement/resource/routes/app_routes.dart';
import 'package:placement/resource/routes/routs.dart';
import 'package:placement/view_models/user_controller/user_controller.dart'; // UserController import

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ✅ Get the UserController instance
  final UserController userController = Get.find<UserController>();

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter email and password",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      // ✅ Firebase login
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null && !user.emailVerified) {
        isLoading.value = false;
        Get.snackbar("Email Not Verified", "Please verify your email before login.");
        return;
      }

      // ✅ Load user data into UserController
      if (user != null) {
        await userController.loadUserData(user.uid);
      }

      isLoading.value = false;
      Get.offAllNamed(AppRouteNames.home);
      Get.snackbar("Success", "Login successful");

    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar("Login Error", e.message ?? "Invalid credentials");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
