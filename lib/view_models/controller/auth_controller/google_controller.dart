// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../../../data/repository/login_repo/social_login/social_account_repository.dart';
// import '../../../utils/snakbar.dart';
// import '../user_controller/user_controller.dart';
// import '../../../models/user_mode/user_model.dart';
//
// class GoogleSignInService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final UserController userController = Get.find<UserController>();
//   final _api = SocialLoginRepository();
//
//   // Function to handle Google Sign-In
//   Future<void> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         Utils.showSnackbar('Error', 'Google sign-in canceled');
//         return;
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       final UserCredential userCredential = await _auth.signInWithCredential(credential);
//       User? user = userCredential.user;
//
//       if (user != null && user.email != null) {
//         await _api.sendUserDataToAPI(user.email!);
//
//         // Updating UserController with user data
//         userController.updateUser(UserModel(
//           id: user.uid,
//           name: user.displayName ?? "",
//           email: user.email,
//           profilePicture: user.photoURL ?? "",
//         ));
//
//         Utils.showSnackbar('Login', 'Logged in successfully');
//
//         // Navigate to home screen after login
//         Get.offAllNamed('/home');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error during Google sign-in: $e");
//       }
//       Utils.showSnackbar('Error', 'Failed to login with Google');
//     }
//   }
// }
