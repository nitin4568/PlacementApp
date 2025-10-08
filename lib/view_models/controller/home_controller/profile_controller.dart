import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../user_controller/user_controller.dart';

class ProfileController extends GetxController {
  final UserController userController = Get.find<UserController>();

  // Editable fields
  final nameController = TextEditingController();
  final collegeController = TextEditingController();
  final branchController = TextEditingController();
  final courseController = TextEditingController();
  final rollNoController = TextEditingController();

  var profileImage = "assets/png/user.png".obs;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  void loadUser() {
    final user = userController.user.value;
    if (user != null) {
      nameController.text = user.name ?? "";
      collegeController.text = user.college ?? "";
      branchController.text = user.branch ?? "";
      courseController.text = user.course ?? "";
      rollNoController.text = user.rollNo ?? "";

      profileImage.value = user.profilePicture?.isNotEmpty == true
          ? user.profilePicture!
          : "assets/png/user.png";
    }
  }

  void logout() {
    // Handle logout logic
  }

  /// Save edited info to UserController + Firestore
  Future<void> saveProfile() async {
    final user = userController.user.value;
    if (user == null) return;

    userController.updateName(nameController.text);
    userController.updateCollege(collegeController.text);
    userController.updateBranch(branchController.text);
    userController.updateCourse(courseController.text);
    userController.updateRollNo(rollNoController.text);

    await userController.saveUserData();

    Get.snackbar(
      "Success",
      "Profile updated successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
