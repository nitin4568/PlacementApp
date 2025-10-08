import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:placement/resource/routes/app_routes.dart';
import 'package:placement/resource/routes/routs.dart';

class SignupController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final collegeController = TextEditingController();
  final branchController = TextEditingController();
  final courseController = TextEditingController();
  final rollNoController = TextEditingController();
  final phoneController = TextEditingController();
  var isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signup() async {
    final name = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    try {
      isLoading.value = true;

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.sendEmailVerification();

      // Save temp data
      await _firestore.collection('users_temp').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.offAllNamed(AppRouteNames.emailVerification,
          arguments: {'fullName': name, 'email': email});
      Get.snackbar("Success", "Verification link sent to your email");

    } on FirebaseAuthException catch (e) {
      Get.snackbar("Signup Error", e.message ?? "Error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
