import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:placement/data/repository/homepage_repository/resume_repository.dart';
import 'package:placement/models/home_models/resume_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ResumeController extends GetxController {
  final ResumeRepository repository = ResumeRepository();

  Rx<ResumeAnalysis?> analysis = Rx<ResumeAnalysis?>(null);
  RxBool loading = false.obs;
  Rx<File?> selectedFile = Rx<File?>(null);

  /// Pick resume file
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'png', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.single.path != null) {
      selectedFile.value = File(result.files.single.path!);
    }
  }

  /// Analyze resume
  Future<void> analyze() async {
    if (selectedFile.value == null) return;
    try {
      loading.value = true;
      final result = await repository.analyzeResume(selectedFile.value!);
      analysis.value = result;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }

  /// Request storage permission for Android
  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      return status.isGranted;
    }
    return true; // iOS doesn't need extra permission
  }

  /// Generate PDF report and save to device Downloads
  Future<void> generateAndSavePdf() async {
    if (analysis.value == null) {
      Get.snackbar("Error", "No analysis available!");
      return;
    }

    if (!await _requestPermission()) {
      Get.snackbar("Permission Denied", "Cannot save PDF without storage permission");
      return;
    }

    try {
      final pdf = pw.Document();

      // Build PDF content
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Resume Analysis Report",
                    style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text("ATS Score: ${analysis.value!.atsScore.toStringAsFixed(1)}%"),
                pw.SizedBox(height: 10),
                pw.Text("Recommendations:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Bullet(text: analysis.value!.recommendations.join("\n• ")),
              ],
            );
          },
        ),
      );

      // Get Downloads directory
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download'); // Downloads folder
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      final filePath = '${directory.path}/resume_analysis_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      Get.snackbar("Success", "PDF saved at: $filePath");
    } catch (e) {
      Get.snackbar("Error", "Failed to generate PDF: $e");
    }
  }
}
//
// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:path_provider/path_provider.dart';
// import 'package:placement/data/repository/homepage_repository/resume_repository.dart';
// import 'package:placement/models/home_models/resume_model.dart';
//
// class ResumeController extends GetxController {
//   final ResumeRepository repository = ResumeRepository();
//
//   Rx<ResumeAnalysis?> analysis = Rx<ResumeAnalysis?>(null);
//   RxBool loading = false.obs;
//   Rx<File?> selectedFile = Rx<File?>(null);
//
//   /// Request storage permission
//   Future<bool> _requestStoragePermission() async {
//     if (Platform.isAndroid) {
//       var readStatus = await Permission.storage.status;
//       if (!readStatus.isGranted) {
//         readStatus = await Permission.storage.request();
//       }
//       return readStatus.isGranted;
//     }
//     return true; // iOS does not need
//   }
//
//   /// Pick resume file (asks permission)
//   Future<void> pickFile() async {
//     if (!await _requestStoragePermission()) {
//       Get.snackbar("Permission Denied", "Cannot access files without permission");
//       return;
//     }
//
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'docx', 'png', 'jpg', 'jpeg'],
//     );
//
//     if (result != null && result.files.single.path != null) {
//       selectedFile.value = File(result.files.single.path!);
//     }
//   }
//
//   /// Analyze resume
//   Future<void> analyze() async {
//     if (selectedFile.value == null) return;
//     try {
//       loading.value = true;
//       final result = await repository.analyzeResume(selectedFile.value!);
//       analysis.value = result;
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       loading.value = false;
//     }
//   }
//
//   /// Generate PDF and save to device (asks permission)
//   Future<void> generateAndSavePdf() async {
//     if (analysis.value == null) {
//       Get.snackbar("Error", "No analysis available!");
//       return;
//     }
//
//     if (!await _requestStoragePermission()) {
//       Get.snackbar("Permission Denied", "Cannot save PDF without permission");
//       return;
//     }
//
//     final pdf = pw.Document();
//
//     // Build PDF content
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text("Resume Analysis Report",
//                   style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 20),
//               pw.Text("ATS Score: ${analysis.value!.atsScore.toStringAsFixed(1)}%"),
//               pw.SizedBox(height: 10),
//               pw.Text("Recommendations:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//               pw.Bullet(text: analysis.value!.recommendations.join("\n• ")),
//             ],
//           );
//         },
//       ),
//     );
//
//     // Save in app-specific folder (no extra permission needed)
//     Directory? directory = Platform.isAndroid
//         ? await getExternalStorageDirectory()
//         : await getApplicationDocumentsDirectory();
//
//     final filePath =
//         '${directory!.path}/resume_analysis_${DateTime.now().millisecondsSinceEpoch}.pdf';
//     final file = File(filePath);
//     await file.writeAsBytes(await pdf.save());
//
//     Get.snackbar("Success", "PDF saved at: $filePath");
//   }
// }
