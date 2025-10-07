import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/view_models/controller/home_controller/upcoming_controller.dart';
import 'package:placement/resource/components/home_screen_components/upcoming_event_widget.dart';

class UpcomingEventList extends StatelessWidget {
  final UpcomingEventController controller = Get.find<UpcomingEventController>();

  UpcomingEventList({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Upcoming Exams",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.events.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          itemCount: controller.events.length,
          itemBuilder: (context, index) {
            final event = controller.events[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: UpcomingEventWidget(
                title: event.title,
                date: event.date,
                link: event.link,
                isNavigation: false,
              ),
            );
          },
        );
      }),
    );
  }
}
