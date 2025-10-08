
import 'package:get/get.dart';
import 'package:placement/view_models/user_controller/user_controller.dart';


class DependencyInjection {
  static Future<void> init() async {
    Get.put<UserController>(UserController(), permanent: true);

    // Get.put<LanguageController>(LanguageController(), permanent: true);

    // Get.put<BottomNavViewModel>(BottomNavViewModel(), permanent: true);

  }
}
