import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:placement/resource/url/config.dart';

class AIRepositoryTest {
  /// Fetch question from Gemini Lite
  Future<String> fetchTestQuestion(String prompt) async {
    final url = Uri.parse(ApiConfig.geminiBaseUrlTest);

    final body = jsonEncode({
      "contents": [
        {"parts": [{"text": prompt}]}
      ]
    });

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "X-goog-api-key": ApiConfig.geminiApiKeyTest
        },
        body: body,
      );

      print("API raw response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['candidates'] != null &&
            data['candidates'].isNotEmpty &&
            data['candidates'][0]['content'] != null &&
            data['candidates'][0]['content']['parts'] != null &&
            data['candidates'][0]['content']['parts'].isNotEmpty &&
            data['candidates'][0]['content']['parts'][0]['text'] != null) {
          return data['candidates'][0]['content']['parts'][0]['text'];
        } else {
          throw Exception("No content found in API response");
        }
      } else {
        throw Exception(
            "Failed API call: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("AIRepositoryTest Error: $e");
      rethrow;
    }
  }
}