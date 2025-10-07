import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/components/buttons_components/black_continue_buttons.dart';
import 'package:placement/resource/routes/routs.dart';

class MockTestWidget extends StatefulWidget {
  const MockTestWidget({super.key});

  @override
  State<MockTestWidget> createState() => _MockTestWidgetState();
}

class _MockTestWidgetState extends State<MockTestWidget> {
  String searchQuery = "";

  void _showTestSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: const Text(
            "Enter Test Name",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                TextField(
                  decoration: InputDecoration(
                    hintText: "Type test name...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 8.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() => searchQuery = value.trim());
                  },
                ),
                SizedBox(height: 12.h),

                // Show dynamic "test" based on user input
                SizedBox(
                  height: 150.h,
                  child: searchQuery.isEmpty
                      ? Center(
                    child: Text(
                      "Type something to generate a test",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  )
                      : ListView(
                    children: [
                      Card(
                        color: Colors.grey.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.assignment_outlined,
                            color: Colors.black,
                          ),
                          title: Text(
                            searchQuery,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 16),
                          onTap: () {
                            Get.back();
                            Get.toNamed(AppRouteNames.test,
                                arguments: searchQuery);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Prepare for Placements",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            "Type any test name and start the test instantly.",
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: BlackContinueButton(
              onPressed: () => _showTestSelectionDialog(context), title: 'Start Test',


            ),
          ),
        ],
      ),
    );
  }
}
