import 'package:get/get.dart';

class HomeController extends GetxController {
  // Reactive index for BottomNavigationBar
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
