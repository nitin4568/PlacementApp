import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:placement/resource/components/buttons_components/simple_button.dart';
import 'package:placement/view_models/controller/home_controller/job_controller.dart';
import 'package:placement/resource/urllouncher_helper.dart';

class PlacementDriveWidget extends StatelessWidget {
  PlacementDriveWidget({super.key});

  // Use Get.find instead of Get.put
  final JobController controller = Get.find<JobController>();

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive sizing
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final job = controller.latestJob.value;
      if (job == null) {
        return const Center(child: Text("No job available"));
      }

      return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Left side: text + button
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.company,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      job.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Apply by: ${job.deadline}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    /// Apply Button
                    CustomButton(
                      text: "Apply",
                      onPressed: () async {
                        String link = job.applyLink.trim();
                        if (link.isEmpty || !link.startsWith("http")) {
                          Get.snackbar("Info", "Apply link not available. Redirecting to test link.");
                          link = "https://studyfordreams.in/";
                        }
                        await UrlLauncherHelper.openUrl(link);
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              /// Right side: image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 80.w,
                  height: 80.h,
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.business,
                    size: 40.sp,
                    color: Colors.grey,
                  ),
                ),
              )

            ],
          ),
        ),
      );
    });
  }
}
