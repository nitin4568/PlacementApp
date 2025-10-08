import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:placement/models/user_mode/user_model.dart';
import 'package:placement/resource/routes/app_routes.dart';
import 'package:placement/resource/routes/routs.dart';
import 'package:placement/view_models/user_controller/user_controller.dart';

class EmailVerificationController extends GetxController {
  var isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController userController = Get.find<UserController>();

  Future<void> checkEmailVerified(String fullName) async {
    isLoading.value = true;
    User? user = _auth.currentUser;

    await user?.reload();
    user = _auth.currentUser;

    if (user != null && user.emailVerified) {
      final tempDoc = await _firestore.collection('users_temp').doc(user.uid).get();

      final newUser = UserModel(
        id: user.uid,
        name: fullName,
        email: user.email,
        phone: tempDoc['phone'],
        profilePicture: '',
      );

      // Save to main users collection
      await _firestore.collection('users').doc(user.uid).set(newUser.toJson());

      // Remove temp doc
      await _firestore.collection('users_temp').doc(user.uid).delete();

      // Update UserController
      userController.updateUser(newUser);

      Get.offAllNamed(AppRouteNames.home);
    } else {
      Get.snackbar("Not Verified", "Please verify your email first.");
    }
    isLoading.value = false;
  }
}
