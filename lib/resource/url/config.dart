// class ApiConfig {
//   static const String baseUrl = '';
//   static const String apiVersion = 'api/';
//   static const String geminiApiKeyChat = "AIzaSyBMkFU-jOWgHr4GOmLJhX0kVVPtLHBc88g";
//   static const String geminiBaseUrlChat = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";
//   static const String geminiBaseUrlTest = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-lite:generateContent";
//   static const String geminiApiKeyTest="AIzaSyBwQhWhw9zZ_9zVuJhDePq-0EvtMSJMm9Y";
//   static const String geminiApiKeyResume="AIzaSyAsLi3vnsCKHuUzpaK1zzRrpciiQaBgA1I";
//   static const String geminiBaseUrlResume="https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-pro:generateContent";
//   static const String geminiBaseUrlUncomingevent = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-lite:generateContent";
//   static const String geminiApiKeyUncomigevent="AIzaSyDp1d0Db-I4VFRfqbY8LJYeSFdMu4Nr2pk";
//   static const String geminiApiKeyLecture="AIzaSyBPFOiT647n15R47ErqZMoQUnEV3jsta0E";
//   static const String geminiBaseUrlLecture = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-lite:generateContent";
//   static const String youtubeApiKey = "AIzaSyAB8fc2c9JKZlKnGv_Dw3FkSgoUP-dw3ZY";
//   static const String youtubeBaseUrl =
//       "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&q=Data%20Structures%20in%20Hindi&maxResults=5&key=";
//
// }
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static const String baseUrl = '';
  static const String apiVersion = 'api/';
  static String get geminiApiKeyChat => dotenv.env['GEMINI_API_KEY_CHAT'] ?? '';
  static String get geminiBaseUrlChat => dotenv.env['GEMINI_BASE_URL_CHAT'] ?? '';

  static String get geminiApiKeyTest => dotenv.env['GEMINI_API_KEY_TEST'] ?? '';
  static String get geminiBaseUrlTest => dotenv.env['GEMINI_BASE_URL_TEST'] ?? '';

  static String get geminiApiKeyResume => dotenv.env['GEMINI_API_KEY_RESUME'] ?? '';
  static String get geminiBaseUrlResume => dotenv.env['GEMINI_BASE_URL_RESUME'] ?? '';

  static String get geminiApiKeyUncomigevent => dotenv.env['GEMINI_API_KEY_UNCOMINGEVENT'] ?? '';
  static String get geminiBaseUrlUncomingevent => dotenv.env['GEMINI_BASE_URL_UNCOMINGEVENT'] ?? '';

  static String get geminiApiKeyLecture => dotenv.env['GEMINI_API_KEY_LECTURE'] ?? '';
  static String get geminiBaseUrlLecture => dotenv.env['GEMINI_BASE_URL_LECTURE'] ?? '';

  static String get youtubeApiKey => dotenv.env['YOUTUBE_API_KEY'] ?? '';
  static String get youtubeBaseUrl => dotenv.env['YOUTUBE_BASE_URL'] ?? '';
}
