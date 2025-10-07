import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:placement/data/nretwork/base_api_service.dart';
import 'exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url,
      {Map<String, String>? headers, Map<String, String>? params}) async {
    if (kDebugMode) {
      print('URL: $url');
      print('Headers: $headers');
      print('Parameters: $params');
    }
    dynamic responseJson;

    try {
      Uri uri = Uri.parse(url);
      if (params != null) {
        uri = uri.replace(queryParameters: params);
      }

      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 60));
      responseJson = finalResponseJson(response);
    } on SocketException {
      throw NetworkException();
    } on TimeoutException {
      throw RequestTimeOutException();
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApi(String url, var data, {String? authToken} ) async {
    if (kDebugMode) {
      print('URL: $url');
      print('Data: $data');
    }
    dynamic responseJson;

    try {
      final headers = {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };
      final response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: 20));
      responseJson = finalResponseJson(response);
    } on SocketException {
      throw NetworkException();
    } on TimeoutException {
      throw RequestTimeOutException();
    }
    return responseJson;
  }

  Future<dynamic> putApi(String url, var data, {String? authToken}) async {
    if (kDebugMode) {
      print('URL: $url');
      print('Data: $data');
    }
    dynamic responseJson;

    try {
      final headers = {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

      final response = await http
          .put(Uri.parse(url), headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: 10));
      responseJson = finalResponseJson(response);
    } on SocketException {
      throw NetworkException();
    } on TimeoutException {
      throw RequestTimeOutException();
    }
    return responseJson;
  }

  /// **Newly added PATCH method for password reset**
  Future<dynamic> patchApi(String url, var data, {String? authToken}) async {
    if (kDebugMode) {
      print('PATCH URL: $url');
      print('Data: $data');
    }
    dynamic responseJson;

    try {
      final headers = {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

      final response = await http
          .patch(Uri.parse(url), headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: 10));
      responseJson = finalResponseJson(response);
    } on SocketException {
      throw NetworkException();
    } on TimeoutException {
      throw RequestTimeOutException();
    }
    return responseJson;
  }
}

dynamic finalResponseJson(http.Response response) {
  if (kDebugMode) {
    print('Response Code: ${response.statusCode}');
    print('Response: ${response.body}');
  }
  switch (response.statusCode) {
    case 200:
    case 201:
      return jsonDecode(response.body);

    case 400:
      throw BadRequestException("Bad request");

    case 401:
      throw UnauthorizedException();

    case 404:
      throw NotFoundException();

    case 409:
      throw UserExistException();

    case 500:
      throw ServerErrorException();

    default:
      throw Exception("Unknown error occurred: ${response.statusCode}");
  }
}
