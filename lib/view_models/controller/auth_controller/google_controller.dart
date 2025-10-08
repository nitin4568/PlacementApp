import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../models/user_mode/user_model.dart';
import '../../user_controller/user_controller.dart';
import '../../../resource/snackbar/snackbar.dart';
import 'package:placement/data/repository/auth_repo/social_login/social_account_repository.dart';

class GoogleSignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  final UserController userController = Get.find<UserController>();
  final SocialLoginRepository _api = SocialLoginRepository();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Utils.showSnackbar('Error', 'Google sign-in canceled');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null && user.email != null) {
        await _api.sendUserDataToAPI(user.email!);

        userController.updateUser(UserModel(
          id: user.uid,
          name: user.displayName ?? "User",
          email: user.email!,
          profilePicture: user.photoURL ?? "",
        ));

        Utils.showSnackbar('Login', 'Logged in successfully');

        Get.offAllNamed('/home');
      } else {
        Utils.showSnackbar('Error', 'User data not found');
      }
    } catch (e) {
      if (kDebugMode) print("Error during Google sign-in: $e");
      Utils.showSnackbar('Error', 'Failed to login with Google');
    }
  }
}
