
class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = "Network error occurred."]);
}

class RequestTimeOutException implements Exception {
  final String message;
  RequestTimeOutException([this.message = "Request timed out."]);
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException([this.message = "Bad request."]);
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException([this.message = "Unauthorized access."]);
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException([this.message = "Resource not found."]);
}

class UserExistException implements Exception {
  final String message;
  UserExistException([this.message = "User already exists."]);
}

class ServerErrorException implements Exception {
  final String message;
  ServerErrorException([this.message = "Server error occurred."]);
}
