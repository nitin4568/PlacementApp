import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class UrlLauncherHelper {
  UrlLauncherHelper._(); // private constructor

  static Future<void> openUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);

    try {
      bool launched = await launchUrl(url, mode: LaunchMode.externalApplication);

      if (!launched) {
        launched = await launchUrl(url, mode: LaunchMode.inAppWebView);
      }

      if (!launched) {
        Get.snackbar("Error", "Cannot open link: $urlString");
      }
    } catch (e) {
      print("Launch error: $e");
      Get.snackbar("Error", "Something went wrong while opening link");
    }
  }
}
