import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placement/resource/components/dilog/comommon_dilogbox.dart';

import '../../resource/components/buttons_components/simple_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  // Menu item widget
  Widget buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: Colors.black, size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  // Sign out logic
  void signOut(BuildContext context) {
    // FirebaseAuth.instance.signOut(); // uncomment if using Firebase Auth
    Get.offAllNamed('/login'); // navigate back to login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),

          // About App
          buildMenuItem(Icons.info_outline, "About App", () {
            CommonDialogBox.show(
              context: context,
              title: "About App",
              description:
              "This Placement App helps students prepare for placements, track drives, "
                  "and manage their career journey efficiently.",
            );
          }),

          // Privacy Policy
          buildMenuItem(Icons.privacy_tip_outlined, "Privacy Policy", () {
            CommonDialogBox.show(
              context: context,
              title: "Privacy Policy",
              description:
              "We respect your privacy. Your data remains secure and is never shared with third parties. "
                  "We only collect minimal information to improve user experience.",
            );
          }),

          // Help & Support
          buildMenuItem(Icons.help_outline, "Help & Support", () {
            CommonDialogBox.show(
              context: context,
              title: "Help & Support",
              description: "For any queries, contact:\n\n📧 nkgautam1450@gmail.com",
            );
          }),

          // Feedback & Rating
          buildMenuItem(Icons.star_rate_rounded, "Feedback & Rating", () {
            CommonDialogBox.show(
              context: context,
              title: "Feedback & Rating",
              description: "⭐ Give your rating and share your experience with our app.",
              showRating: true,
            );
          }),

          Spacer(),

          // Sign Out button
          Container(
            margin: EdgeInsets.all(16.w),
            width: double.infinity,
            child: CustomButton(
              onPressed: () {
                bool isLoading = false;

                Get.dialog(
                  StatefulBuilder(
                    builder: (context, setState) => Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Are you sure you want to sign out?",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.h),
                            if (isLoading)
                              CircularProgressIndicator(color: Colors.black)
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => Get.back(), // Close dialog
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade300,
                                      foregroundColor: Colors.black,
                                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    child: Text("No", style: TextStyle(fontSize: 14.sp)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      setState(() => isLoading = true); // Show loader
                                      await Future.delayed(const Duration(seconds: 1)); // simulate sign-out

                                      // TODO: Actual sign-out logic
                                      // FirebaseAuth.instance.signOut();

                                      Get.offAllNamed('/login'); // Navigate to login
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red.shade600,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    child: Text("Yes", style: TextStyle(fontSize: 14.sp)),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  barrierDismissible: false,
                );
              },
              text: 'Sign Out',
            ),
          )


        ],
      ),
    );
  }
}
