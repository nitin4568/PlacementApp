import 'dart:convert';
import 'package:placement/data/nretwork/network_api_service.dart';
import 'package:placement/data/nretwork/exceptions.dart';
import 'package:placement/resource/url/config.dart';
import 'package:placement/models/home_models/lecture_model.dart';

class LectureRepository {
  final NetworkApiServices _apiService = NetworkApiServices();

  Future<List<Lecture>> searchLectures(String query, {int maxResults = 10}) async {
    final url =
        "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=$maxResults&q=$query&key=${ApiConfig.youtubeApiKey}";

    try {
      final response = await _apiService.getApi(url);

      if (response != null && response['items'] != null) {
        final List<dynamic> items = response['items'];

        // Convert YT API response into Lecture model list
        return items.map((item) {
          final snippet = item['snippet'];
          final videoId = item['id']['videoId'];
          return Lecture(
            title: snippet['title'] ?? '',
            lecturer: snippet['channelTitle'] ?? '',
            details: snippet['description'] ?? '',
            youtubeLink: "https://www.youtube.com/watch?v=$videoId",
          );
        }).toList();
      } else {
        return [];
      }
    } on NetworkException {
      throw Exception("Network error. Check your connection.");
    } on RequestTimeOutException {
      throw Exception("Request timed out. Try again.");
    } on BadRequestException {
      throw Exception("Bad request.");
    } on UnauthorizedException {
      throw Exception("Unauthorized request.");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
