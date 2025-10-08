import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../view_models/controller/auth_controller/google_controller.dart';
import '../../Images/images.dart';

class SocialAccountsHelper extends StatelessWidget {
  SocialAccountsHelper({super.key});
  final GoogleSignInService googleSignInService = GoogleSignInService();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 0.5.w,
            color: Get.theme.brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              await googleSignInService.signInWithGoogle();
            },
            child: SvgPicture.asset(
              AppAssets.googleLogo,
              width: 30.w,
              height: 30.h,
            ),
          ),
        ),
      ),
    );
  }
}
