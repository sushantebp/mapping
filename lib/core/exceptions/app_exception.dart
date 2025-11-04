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

class LocationException extends AppException {
  LocationException([super.message]);

  factory LocationException.permissionDenied() =>
      LocationException('Location permission denied.');

  factory LocationException.serviceDisabled() =>
      LocationException('Location services are disabled.');

  factory LocationException.permissionDeniedForever() =>
      LocationException('Location permission permanently denied.');

  factory LocationException.unknown([String? message]) =>
      LocationException(message ?? 'Unknown location error occurred.');
}

class UnknownnException extends AppException {
  UnknownnException([super.message = "Something went wrong."]);
}
