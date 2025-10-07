import 'dart:convert';
import 'package:placement/data/nretwork/network_api_service.dart';
import 'package:placement/data/nretwork/exceptions.dart';
import 'package:placement/resource/url/config.dart';

class AIRepository {
  final NetworkApiServices _apiService = NetworkApiServices();

  Future<String> getAIResponse(String userQuery) async {
    final url = "${ApiConfig.geminiBaseUrlChat}?key=${ApiConfig.geminiApiKeyChat}";


    final body = {
      "contents": [
        {
          "parts": [
            {"text": userQuery}
          ],
          "role": "user"
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
        final text = content['parts'][0]['text'];
        return text ?? "I couldn't understand that, please try again.";
      } else {
        return "I couldn't understand that, please try again.";
      }
    } on NetworkException {
      return "Network error. Check your connection.";
    } on RequestTimeOutException {
      return "Request timed out. Try again.";
    } on BadRequestException {
      return "Bad request.";
    } on UnauthorizedException {
      return "Unauthorized request.";
    } on NotFoundException {
      return "Resource not found.";
    } on UserExistException {
      return "User already exists.";
    } on ServerErrorException {
      return "Server error. Please try later.";
    } catch (e) {
      return "Unexpected error: $e";
    }
  }
}
