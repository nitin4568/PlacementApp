import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/colors/Color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  // final String labelText;
  // final double width;
  final TextEditingController? controller;
  final double borderWidth;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({
    required this.hintText,
    // required this.labelText,
    // this.width = 300.0,
    this.borderWidth = 0.0, // default no border
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width,
      height: 50.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8F2), // box background color
        borderRadius: BorderRadius.circular(10), // thoda rounded box
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          // labelText: labelText,
          labelStyle: TextStyle(color: AppColors.lightGrey),
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.lightGrey, fontSize: 14.sp),
          isDense: true,
          border: InputBorder.none, // border remove
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }
}
