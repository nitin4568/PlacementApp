import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:placement/resource/components/buttons_components/simple_button.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:placement/view_models/controller/home_controller/resume_controler.dart';

class ResumeAnalyzerScreen extends StatelessWidget {
  final ResumeController controller = Get.find<ResumeController>();

  ResumeAnalyzerScreen({Key? key}) : super(key: key);

  Widget uploadBox(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            "Drag and drop or upload your resume",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            "Upload your resume in PDF or Word format to get started.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 14.sp),
          ),
          SizedBox(height: 16.h),
          Obx(() => controller.loading.value
              ? const CircularProgressIndicator()
              : CustomButton(
            onPressed: () => controller.pickFile(), text: 'Upload',
          )),
        ],
      ),
    );
  }

  Widget atsGauge(double score) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 100,
              ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 50, color: Colors.red),
                GaugeRange(startValue: 50, endValue: 75, color: Colors.orange),
                GaugeRange(startValue: 75, endValue: 100, color: Colors.green),
              ],
              pointers: <GaugePointer>[NeedlePointer(value: score, enableAnimation: true)],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Text(
                    "${score.toStringAsFixed(1)}%",
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  angle: 90,
                  positionFactor: 0.8,
                )
              ],
            )
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          score < 50 ? "Needs Improvement" : (score < 75 ? "Better" : "Best"),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.black87),
        ),
      ],
    );
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();
    final analysis = controller.analysis.value;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Resume Analysis Report",
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text("ATS Score: ${analysis?.atsScore.toStringAsFixed(1) ?? 0}%"),
            pw.SizedBox(height: 20),
            pw.Text("Recommendations:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            if (analysis != null) ...analysis.recommendations.map((r) => pw.Bullet(text: r)),
          ],
        ),
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/resume_analysis.pdf');
    await file.writeAsBytes(await pdf.save());

    Get.snackbar("PDF Saved", "Report saved at: ${file.path}");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Resume Analyzer", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              double score = controller.analysis.value?.atsScore.toDouble() ?? 0;
              return atsGauge(score);
            }),
            SizedBox(height: 16.h),
            uploadBox(context),
            SizedBox(height: 20.h),
            Obx(() => controller.selectedFile.value != null
                ? Text(
              "Selected: ${controller.selectedFile.value!.path.split('/').last}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
            )
                : SizedBox()),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => controller.analyze(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text("Analyze Resume", style: TextStyle(fontSize: 16.sp)),
            ),
            SizedBox(height: 24.h),
            Obx(() {
              final analysis = controller.analysis.value;
              if (analysis == null) return SizedBox();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Key Recommendations",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.h),
                    Text(
                      analysis.recommendations.map((r) => "• $r").join("\n"),
                      style: TextStyle(color: Colors.black87, fontSize: 14.sp),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 20.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              width: double.infinity,

             ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
