import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:placement/resource/images/images.dart';
import 'package:placement/resource/routes/routs.dart';
import 'package:placement/view_models/controller/home_controller/home_controller.dart';

class CustomBottomNavbar extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  CustomBottomNavbar({super.key});

  void _onItemTapped(int index) {
    controller.changeIndex(index);

    switch (index) {
      case 0:
        Get.toNamed(AppRouteNames.home);
        break;
      case 1:
        Get.toNamed(AppRouteNames.test);
        break;
      case 2:
        Get.toNamed(AppRouteNames.aiChats);
        break;
      case 3:
        Get.toNamed(AppRouteNames.lecture);
        break;
      case 4:
        Get.toNamed(AppRouteNames.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          currentIndex: controller.selectedIndex.value,
          onTap: _onItemTapped,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.home,
                height: 32,
                colorFilter: ColorFilter.mode(
                  controller.selectedIndex.value == 0
                      ? Colors.black
                      : Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.tests,
                height: 32,
                colorFilter: const ColorFilter.mode(
                    Colors.black, BlendMode.srcIn),
              ),
              label: "Tests",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.ai,
                height: 32,
                colorFilter: const ColorFilter.mode(
                    Colors.black, BlendMode.srcIn),
              ),
              label: "AI Chats",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.lecture,
                height: 32,
                colorFilter: const ColorFilter.mode(
                    Colors.black, BlendMode.srcIn),
              ),
              label: "Lecture",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.profile,
                height: 32,
                colorFilter: const ColorFilter.mode(
                    Colors.black, BlendMode.srcIn),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
