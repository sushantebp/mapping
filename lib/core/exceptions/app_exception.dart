abstract class AppException implements Exception {
  final String? message;
  AppException([this.message]);
  @override
  String toString() => message ?? 'An unknown error occurred.';
}

class ApiException extends AppException {
  final int? statusCode;
  ApiException(this.statusCode, [String? message]) : super(message);
}

class UnknownnException extends AppException {
  UnknownnException([super.message = "Something went wrong."]);
}
