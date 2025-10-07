import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';


class OTPBox extends StatelessWidget {
  final void Function(String)? onCompleted; // jab OTP complete ho
  final void Function(String)? onChanged;   // jab value change ho

  const OTPBox({Key? key, this.onCompleted, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 45.w,
      height: 50.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.r),
      ),
    );

    return Center(
      child: Pinput(
        length: 6,
        defaultPinTheme: defaultPinTheme,
        onChanged: onChanged,
        onCompleted: onCompleted,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
