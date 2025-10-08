import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/view_models/controller/home_controller/save_video_controller.dart';
import 'package:placement/resource/urllouncher_helper.dart';

class SaveVideoScreen extends StatelessWidget {
  const SaveVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    final controller = Get.find<VideoController>();

    return Scaffold(
      backgroundColor: Colors.white, // Scaffold background
      appBar: AppBar(
        title: const Text("Saved Videos"),
        backgroundColor: Colors.white, // AppBar background
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white, // Ensure entire body background is white
        child: Obx(() {
          final savedVideos = controller.savedVideos;

          if (savedVideos.isEmpty) {
            return Center(
              child: Text(
                "No saved videos yet.",
                style: TextStyle(fontSize: 16.sp),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(12.w),
            itemCount: savedVideos.length,
            itemBuilder: (context, index) {
              final video = savedVideos[index];

              return Card(
                color: Colors.white, // Card background
                margin: EdgeInsets.symmetric(vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 2,
                child: ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                  leading: Icon(Icons.video_library, size: 30.sp, color: Colors.teal),
                  title: Text(video.title ?? "Video ${index + 1}",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  subtitle: Text(video.description ?? "",
                      style: TextStyle(fontSize: 14.sp)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Open YouTube
                      IconButton(
                        icon: Icon(Icons.open_in_new, size: 24.sp, color: Colors.blue),
                        onPressed: () async {
                          if (video.youtubeLink == null ||
                              !video.youtubeLink!.startsWith("http")) {
                            Get.snackbar("Error", "YouTube link not available");
                            return;
                          }
                          await UrlLauncherHelper.openUrl(video.youtubeLink!);
                        },
                      ),
                      // Remove video
                      IconButton(
                        icon: Icon(Icons.delete, size: 24.sp, color: Colors.red),
                        onPressed: () {
                          controller.removeVideo(video);
                          Get.snackbar(
                              "Removed", "${video.title ?? 'Video'} removed");
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
