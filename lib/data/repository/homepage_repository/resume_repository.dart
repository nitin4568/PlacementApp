import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:placement/models/home_models/resume_model.dart';
import 'package:placement/resource/url/config.dart';

class ResumeRepository {
  Future<ResumeAnalysis> analyzeResume(File file) async {
    final bytes = await file.readAsBytes();
    final base64File = base64Encode(bytes);


    final requestBody = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {
              "text": """
Read this resume and provide:
1. ATS score (0-100%)
2. Summary
3. Key recommendations

Resume Content (base64 encoded):
$base64File
              """
            }
          ]
        }
      ]
    };

    try {
      final url =
          "${ApiConfig.geminiBaseUrlResume}?key=${ApiConfig.geminiApiKeyResume}";

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final candidates = data['candidates'];
        if (candidates != null && candidates.isNotEmpty) {
          final text =
              candidates[0]['content']?['parts']?[0]?['text'] ?? '';


          final atsScore = _extractAtsScore(text);
          final summary = _extractSummary(text);
          final recommendations = _extractRecommendations(text);

          return ResumeAnalysis(
            atsScore: atsScore,
            summary: summary,
            recommendations: recommendations,
          );
        } else {
          throw Exception("Invalid response: No candidates found.");
        }
      } else {
        throw Exception(
            "Failed to analyze resume: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception("Error analyzing resume: $e");
    }
  }

  /// Helper functions to extract info from AI response text
  int _extractAtsScore(String text) {
    final regex = RegExp(r'(\d{1,3})%');
    final match = regex.firstMatch(text);
    if (match != null) {
      return int.tryParse(match.group(1)!) ?? 0;
    }
    return 0;
  }

  String _extractSummary(String text) {
    final regex = RegExp(r'Summary[:\-]?\s*(.*)', caseSensitive: false);
    final match = regex.firstMatch(text);
    return match != null ? match.group(1)!.trim() : "No summary found.";
  }

  List<String> _extractRecommendations(String text) {
    final regex = RegExp(r'(?:(?:\d+\.|•)\s*)([^\n]+)');
    return regex
        .allMatches(text)
        .map((m) => m.group(1)!.trim())
        .toList()
        .where((e) => e.isNotEmpty)
        .toList();
  }
}
