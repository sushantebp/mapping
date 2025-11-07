abstract class AppException implements Exception {
  final String? message;

  AppException([this.message]);

  @override
  String toString() => message ?? 'An unknown error occurred.';
}

class ApiException extends AppException {
  final int? statusCode;

  ApiException(this.statusCode, [String? message]) : super(message);

  @override
  String toString() {
    return 'ApiException (Status Code: $statusCode): ${message ?? 'An error occurred'}';
  }
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

class UnknownException extends AppException {
  UnknownException([super.message = "Something went wrong."]);

  @override
  String toString() =>
      'UnknownException: ${message ?? 'An unknown error occurred.'}';
}

class FetchCafeException extends AppException {
  FetchCafeException([super.message = "Error fetching cafe data."]);

  @override
  String toString() =>
      'FetchCafeException: ${message ?? 'Error fetching cafe data.'}';
}

class FetchPlaceOfWorshipException extends AppException {
  FetchPlaceOfWorshipException([
    super.message = "Error fetching place of worship data.",
  ]);

  @override
  String toString() =>
      'FetchPlaceOfWorshipException: ${message ?? 'Error fetching place of worship data.'}';
}
