import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/components/buttons_components/simple_button.dart';
import 'package:placement/view/home_page/profile_section/edit_profile.dart';
import 'package:placement/view/home_page/profile_section/save_video.dart';
import 'package:placement/view/home_page/setting.dart';
import '../../view_models/controller/home_controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Get.to(() => const SettingsScreen());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // Profile Image with first letter fallback
            Obx(() {
              final user = controller.userController.user.value;
              final name = user?.name ?? "";
              final image = controller.profileImage.value;

              ImageProvider? avatarImage;

              if (image.startsWith('http')) {
                avatarImage = NetworkImage(image);
              } else {
                avatarImage = null; // show first letter
              }

              return CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade400,
                backgroundImage: avatarImage,
                child: avatarImage == null
                    ? Text(
                  name.isNotEmpty ? name[0].toUpperCase() : "?",
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
                    : null,
              );
            }),
            const SizedBox(height: 16),

            // Name
            Obx(() => Text(
              controller.userController.user.value?.name ?? "",
              style: TextStyle(
                  fontSize: 20.sp, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 4),

            // Email
            Obx(() => Text(
              controller.userController.user.value?.email ?? "",
              style: const TextStyle(color: Colors.grey),
            )),
            const SizedBox(height: 30),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.to(() => const SaveVideoScreen());
                    },
                    icon: const Icon(Icons.save, color: Colors.black),
                    label: const Text(
                      "Save Video",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      Get.to(() => const EditProfileScreen());
                    },
                    text: 'Edit Profile',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
