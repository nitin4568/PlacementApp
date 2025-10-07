import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/components/buttons_components/simple_button.dart';
import 'package:placement/view_models/controller/home_controller/mock_tests_controller.dart';

class MockTestScreen extends StatelessWidget {
  final String testType;
  const MockTestScreen({super.key, required this.testType});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    final controller = Get.find<MockTestController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startTest(testType);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("$testType Test"),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Failed to load question.",
                  style: TextStyle(fontSize: 18.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  onPressed: () => controller.retry(testType),
                  text: 'Retry',
                ),
              ],
            ),
          );
        }

        if (controller.testCompleted.value) {
          Future.delayed(const Duration(seconds: 2), () {
            if (Get.currentRoute != '/home') {
              Get.offAllNamed('/home');
            }
          });

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 80.w),
                SizedBox(height: 20.h),
                Text(
                  "Test Completed!",
                  style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  "Your Score: ${controller.score.value}",
                  style: TextStyle(fontSize: 18.sp),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        if (controller.questions.isEmpty ||
            controller.currentIndex.value >= controller.questions.length) {
          return const Center(child: CircularProgressIndicator());
        }

        final question = controller.questions[controller.currentIndex.value];

        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Q${controller.currentIndex.value + 1}. ${question.question}",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "Time: ${controller.timer}s",
                    style: TextStyle(fontSize: 16.sp, color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: question.options.length,
                  itemBuilder: (context, i) {
                    Color? color;
                    if (controller.isAnswered.value) {
                      if (i == question.correctAnswer) color = Colors.green;
                      else if (i == controller.selectedOption.value) color = Colors.red;
                    }

                    return Card(
                      color: color ?? Colors.white,
                      child: ListTile(
                        leading: Radio(
                          value: i,
                          groupValue: controller.selectedOption.value,
                          onChanged: (_) =>
                              controller.selectOption(i, testType),
                        ),
                        title: Text(question.options[i], softWrap: true),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Score: ${controller.score.value}",
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
        );
      }),
    );
  }
}
