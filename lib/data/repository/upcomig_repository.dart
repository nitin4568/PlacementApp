import 'dart:convert';
import 'package:placement/models/home_models/upcoming_model.dart';
import 'package:placement/data/nretwork/network_api_service.dart';
import 'package:placement/data/nretwork/exceptions.dart';
import 'package:placement/resource/url/config.dart';

class UpcomingEventRepository {
  final NetworkApiServices _apiService = NetworkApiServices();

  Future<List<UpcomingEvent>> fetchUpcomingEvents() async {
    final url =
        "${ApiConfig.geminiBaseUrlUncomingevent}?key=${ApiConfig.geminiApiKeyUncomigevent}";

    final body = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {
              "text":
              "List all 20 upcoming exams for students. Return output in JSON array format with fields: title, date, link. Do not include explanations about websites."
            }
          ]
        }
      ]
    };

    try {
      final response = await _apiService.postApi(url, body);

      if (response != null &&
          response['candidates'] != null &&
          response['candidates'].isNotEmpty) {
        final candidate = response['candidates'][0];
        final content = candidate['content'];

        String text = content['parts']?[0]?['text'] ?? "";

        // Remove ```json``` or ``` and newlines
        text = text.replaceAll(RegExp(r"```json"), "");
        text = text.replaceAll(RegExp(r"```"), "").trim();

        try {
          final decoded = jsonDecode(text);

          if (decoded is List) {
            return decoded.map((e) => UpcomingEvent.fromJson(e)).toList();
          } else {
            return [];
          }
        } catch (e) {
          print("JSON parse error: $e");
          return [];
        }
      } else {
        return [];
      }
    } on NetworkException {
      throw Exception("Network error. Check your connection.");
    } on BadRequestException {
      throw Exception("Bad request. Check your payload.");
    } catch (e) {
      throw Exception("Error fetching upcoming events: $e");
    }
  }
}
