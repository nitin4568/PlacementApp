import 'package:get/get.dart';

class ProfileMenu {
  final String title;
  final String subtitle;
  final String image;
  final void Function()? onTap;

  ProfileMenu({
    required this.title,
    required this.subtitle,
    required this.image,
    this.onTap,
  });
}

class ProfileController extends GetxController {
  // User Info
  var name = "Ethan Carter".obs;
  var email = "ethan.carter@email.com".obs;
  var profileImage = "assets/png/user.png".obs;

  // Menu Items
  var menuItems = <ProfileMenu>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMenuItems();
  }

  void loadMenuItems() {
    menuItems.addAll([
      ProfileMenu(
        title: "My Courses",
        subtitle: "View and manage your enrolled courses",
        image: "assets/png/myCourses.png",
        onTap: () {
          // Handle navigation to My Courses
        },
      ),
      ProfileMenu(
        title: "My Tests",
        subtitle: "Review your test history and performance",
        image: "assets/png/mytest.png",
        onTap: () {
          // Handle navigation to My Tests
        },
      ),
      ProfileMenu(
        title: "Achievements",
        subtitle: "Track your progress and unlock rewards",
        image: "assets/png/achievements.png",
        onTap: () {
          // Handle navigation to Achievements
        },
      ),
    ]);
  }

  void logout() {
    // Handle logout logic
  }
}
