import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placement/resource/components/buttons_components/simple_button.dart';
import 'package:placement/resource/urllouncher_helper.dart';

class UpcomingEventWidget extends StatelessWidget {
  final String title;
  final String date;
  final String? link;
  final VoidCallback? onViewDetails;
  final bool isNavigation;

  const UpcomingEventWidget({
    super.key,
    required this.title,
    required this.date,
    this.link,
    this.onViewDetails,
    this.isNavigation = false,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    date,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                    text: isNavigation ? "See All" : "View Details",
                    onPressed: () async {
                      if (isNavigation) {
                        if (onViewDetails != null) onViewDetails!();
                      } else {
                        if (link != null && link!.isNotEmpty) {
                          await UrlLauncherHelper.openUrl(link!);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.teal.shade700,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.book, color: Colors.white, size: 30.sp),
            ),
          ],
        ),
      ),
    );
  }
}
