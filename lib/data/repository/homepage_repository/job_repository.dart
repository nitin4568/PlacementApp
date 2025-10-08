import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:placement/models/home_models/job_model.dart';
import 'package:placement/resource/url/config.dart';

class JobRepository {
  Future<Job> fetchLatestJob() async {
    final prompt = "Generate 1 latest job from Naukri.com in JSON format with title, company, deadline, and applyLink";

    final body = jsonEncode({
      "contents": [
        {"parts": [{"text": prompt}]}
      ]
    });

    final url = Uri.parse(ApiConfig.geminiBaseUrlTest);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "X-goog-api-key": ApiConfig.geminiApiKeyTest,
        },
        body: body,
      );

      print("API raw response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'] as String;

        final start = text.indexOf('{');
        final end = text.lastIndexOf('}');
        if (start == -1 || end == -1) throw Exception("No JSON found");

        final jsonString = text.substring(start, end + 1);
        final jsonData = jsonDecode(jsonString);

        print("Extracted JSON: $jsonData");

        return Job.fromJson(jsonData);
      } else {
        throw Exception("Failed API call: ${response.statusCode}");
      }
    } catch (e) {
      print("JobRepository Error: $e");
      // fallback dummy job to prevent crash
      return Job(
        company: "TCS",
        title: "Software Engineer",
        applyLink: "https://www.tcs.com/careers",
        deadline: "10 Oct 2025",
      );
    }
  }
}
