import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/data/repository/homepage_repository/lecture_repository.dart';
import 'package:placement/view/home_page/profile_section/save_video.dart';
import 'package:placement/view_models/controller/home_controller/lecture_controller.dart';
import 'package:placement/view_models/controller/home_controller/save_video_controller.dart';
import 'package:placement/resource/urllouncher_helper.dart';
import 'package:placement/resource/components/buttons_components/simple_button.dart';

class LectureScreen extends StatelessWidget {
  final LectureController controller = Get.put(
    LectureController(repository: LectureRepository()),
  );

  final VideoController videoController = Get.put(VideoController());

  final TextEditingController searchController = TextEditingController();

  LectureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Lectures",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Get.to(() => const SaveVideoScreen());
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Lecture or Lecturer...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    controller.searchLecture(searchController.text.trim());
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Lecture List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.lectures.isEmpty) {
                  return Center(
                      child: Text("No lectures found",
                          style: TextStyle(fontSize: 14.sp)));
                }

                return ListView.builder(
                  itemCount: controller.lectures.length,
                  itemBuilder: (context, index) {
                    final lecture = controller.lectures[index];

                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Lecture Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          lecture.title,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      // Bookmark icon with Obx
                                      Obx(() {
                                        bool isSaved = videoController.savedVideos
                                            .any((v) => v.title == lecture.title);
                                        return IconButton(
                                          icon: Icon(
                                            isSaved
                                                ? Icons.bookmark
                                                : Icons.bookmark_border,
                                            color: Colors.teal,
                                          ),
                                          onPressed: () {
                                            if (isSaved) {
                                              videoController.removeVideo(
                                                  Video(title: lecture.title));
                                              Get.snackbar("Removed",
                                                  "${lecture.title} removed from saved videos");
                                            } else {
                                              videoController.addVideo(
                                                Video(
                                                  title: lecture.title,
                                                  description: lecture.details,
                                                  youtubeLink:
                                                  lecture.youtubeLink,
                                                  isTemporary: true,
                                                ),
                                              );
                                              Get.snackbar("Saved",
                                                  "${lecture.title} added to saved videos");
                                            }
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    lecture.lecturer,
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.black54),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(lecture.details,
                                      style: TextStyle(fontSize: 14.sp)),
                                  SizedBox(height: 12.h),
                                  CustomButton(
                                    text: "Watch on YouTube",
                                    onPressed: () async {
                                      String link = lecture.youtubeLink.trim();
                                      if (link.isEmpty || !link.startsWith("http")) {
                                        Get.snackbar("Error",
                                            "YouTube link not available");
                                        return;
                                      }
                                      await UrlLauncherHelper.openUrl(link);
                                    },
                                  ),
                                ],
                              ),
                            ),

                            // Video Icon
                            SizedBox(width: 16.w),
                            Container(
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: Colors.teal.shade700,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(Icons.video_collection,
                                  color: Colors.white, size: 30.sp),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
