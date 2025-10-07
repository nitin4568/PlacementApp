import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlackContinueButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final bool isLoading;
  const BlackContinueButton({
    Key? key,
    required this.title,
    this.width = double.infinity,
    this.height = 50,
    required this.onPressed,
    this.isLoading = false, // default false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed, // disable when loading
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
          width: 22.w,
          height: 22.w,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
