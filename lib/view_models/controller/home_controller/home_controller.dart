import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController extends GetxController {
  // Reactive index for BottomNavigationBar
  var selectedIndex = 0.obs;

  // Reactive user name
  RxString userName = "User".obs;

  // Google Sign-In instance
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Change BottomNavigationBar index
  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  // Google Sign-In method
  Future<void> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        // Update userName reactively
        userName.value = account.displayName ?? "User";
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
    }
  }

  // Sign-Out method (optional)
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      userName.value = "User"; // Reset to default
    } catch (e) {
      print("Sign-Out Error: $e");
    }
  }
}
