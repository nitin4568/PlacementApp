import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonDialogBox {
  static void show({
    required BuildContext context,
    required String title,
    required String description,
    bool showRating = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        backgroundColor: Colors.white,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 0.6.sh, // 60% of screen height
            minWidth: double.infinity,
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),


                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                  ),
                  SizedBox(height: 20.h),


                  if (showRating) _RatingAndFeedback(),
                  SizedBox(height: 15.h),


                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 30.w),
                    ),
                    child: Text(
                      "Close",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _RatingAndFeedback extends StatefulWidget {
  @override
  State<_RatingAndFeedback> createState() => _RatingAndFeedbackState();
}

class _RatingAndFeedbackState extends State<_RatingAndFeedback> {
  int selectedStars = 0;
  bool isSaving = false;
  final TextEditingController feedbackController = TextEditingController();

  Future<void> saveFeedback(int rating, String feedback) async {
    try {
      setState(() => isSaving = true);
      await FirebaseFirestore.instance.collection('app_ratings').add({
        'rating': rating,
        'feedback': feedback,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thanks for your $rating⭐ feedback!")),
      );

      feedbackController.clear();
      setState(() => selectedStars = 0);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving feedback: $e")),
      );
    } finally {
      setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
                (index) => IconButton(
              icon: Icon(
                index < selectedStars ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 32.sp,
              ),
              onPressed: () => setState(() => selectedStars = index + 1),
            ),
          ),
        ),


        TextField(
          controller: feedbackController,
          decoration: InputDecoration(
            hintText: "Write your feedback...",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          ),
          maxLines: 3,
        ),
        SizedBox(height: 10.h),


        isSaving
            ? SizedBox(
          width: 24.w,
          height: 24.h,
          child: const CircularProgressIndicator(strokeWidth: 2),
        )
            : ElevatedButton(
          onPressed: selectedStars == 0
              ? null
              : () {
            saveFeedback(selectedStars, feedbackController.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade600,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
          ),
          child: Text(
            "Submit Feedback",
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
