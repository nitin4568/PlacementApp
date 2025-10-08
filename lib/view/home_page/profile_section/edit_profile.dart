import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/components/buttons_components/black_continue_buttons.dart';
import 'package:placement/view_models/controller/home_controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: Colors.white, // Full screen white
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            // Profile Picture
            Obx(() {
              final user = controller.userController.user.value;
              final name = user?.name ?? "";
              final image = controller.profileImage.value;

              ImageProvider? avatarImage;

              if (image.startsWith('http')) {
                avatarImage = NetworkImage(image);
              } else if (image.isNotEmpty && image != "assets/png/user.png") {
                avatarImage = AssetImage(image);
              }

              return Stack(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.white,
                    backgroundImage: avatarImage,
                    child: avatarImage == null
                        ? Text(
                      name.isNotEmpty ? name[0].toUpperCase() : "?",
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                        : null,
                  ),
                ],
              );
            }),
            SizedBox(height: 20.h),

            // Name
            _buildTextField(controller.nameController, "Name"),

            SizedBox(height: 15.h),
            _buildTextField(controller.collegeController, "College / University"),

            SizedBox(height: 15.h),
            _buildTextField(controller.branchController, "Branch / Department"),

            SizedBox(height: 15.h),
            _buildTextField(controller.courseController, "Course / Degree"),

            SizedBox(height: 15.h),
            _buildTextField(controller.rollNoController, "University Roll No."),

            SizedBox(height: 30.h),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: BlackContinueButton(
                onPressed: () async {
                  await controller.saveProfile();
                  // Get.off(() => const ProfileScreen());
                }, title: 'Save',

              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      ),
    );
  }
}
