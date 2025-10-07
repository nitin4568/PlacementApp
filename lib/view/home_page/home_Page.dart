import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/components/buttons_components/floting_action.dart';
import 'package:placement/resource/components/buttons_components/simple_button.dart';
import 'package:placement/resource/components/home_screen_components/lecture_widget.dart';
import 'package:placement/resource/components/home_screen_components/mock_test_widget.dart';
import 'package:placement/resource/components/home_screen_components/placement_drive_widget.dart';
import 'package:placement/resource/components/home_screen_components/resume_builder_widget.dart';
import 'package:placement/resource/components/home_screen_components/section_title.dart';
import 'package:placement/resource/components/home_screen_components/upcoming_event_widget.dart';
import 'package:placement/resource/routes/routs.dart';
import 'package:placement/view/home_page/Aichats.dart';
import 'package:placement/view/upcoming_event/upcoming_event_list.dart';
import 'package:placement/view_models/controller/home_controller/home_controller.dart';
import 'package:placement/view_models/controller/home_controller/upcoming_controller.dart';
import 'package:placement/data/repository/upcomig_repository.dart';
import 'package:placement/resource/components/custom_bottom/custom_bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Use Get.find instead of Get.put
  final HomeController controller = Get.find<HomeController>();
  final UpcomingEventController upcomingController = Get.find<UpcomingEventController>();

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive sizing
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text("Hi, Alex!"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w), // Using ScreenUtil for padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "Placement Drives"),
            PlacementDriveWidget(),
            SizedBox(height: 20.h),

            const SectionTitle(title: "Mock Tests"),
            const MockTestWidget(),
            SizedBox(height: 20.h),

            const SectionTitle(title: "Resume Builder"),
            const ResumeBuilderWidget(),
            SizedBox(height: 20.h),

            const SectionTitle(title: "Upcoming Events"),
            Obx(() {
              if (upcomingController.isLoading.value) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (upcomingController.events.isNotEmpty) {
                final topEvent = upcomingController.events.first;

                return Column(
                  children: [
                    UpcomingEventWidget(
                      title: topEvent.title,
                      date: topEvent.date,
                      link: topEvent.link,
                      isNavigation: false,
                    ),
                    SizedBox(height: 12.h),
                    CustomButton(
                      text: "See All Exams",
                      onPressed: () {
                        Get.toNamed(AppRouteNames.UpcomingEvent);
                      },
                    ),
                  ],
                );
              }

              return const Text(
                "No upcoming events found.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              );
            }),

            SizedBox(height: 20.h),
            const SectionTitle(title: "Lectures"),
            const LectureWidget(),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(right: 1.w, bottom: 10.h),
          child: LottieFAB(
            assetPath: "assets/animation/Welcome Animation.json",
            size: 130.w,
            onPressed: () async {
              await Future.delayed(const Duration(seconds: 1));
              Get.to(() => const AIChatScreen());
            },
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}
