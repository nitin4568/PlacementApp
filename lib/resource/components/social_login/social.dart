import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Images/images.dart'; // Your assets path

class SocialAccountsHelper extends StatelessWidget {
  const SocialAccountsHelper({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
            (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 0.5.w, color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    // TODO: Add social login actions here
                    print(index == 0
                        ? "Google tapped"
                        : index == 1
                        ? "Apple tapped"
                        : "Facebook tapped");
                  },
                  child: SvgPicture.asset(
                    index == 0
                        ? AppAssets.googleLogo
                        : index == 1
                        ? AppAssets.appleLogo
                        : AppAssets.facebookLogo,
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
