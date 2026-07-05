// [OWNER] — Custom exception classes for the entire app.
// [OWNER] — Each exception type represents a different failure category.
// [DEV] — These are thrown in data sources and caught in repositories
// [DEV] — where they are converted to Failure objects (domain-safe).
// [DEV] — Fully standalone: copy this file, import, throw as needed.

/// [DEV] — Base exception for all app-specific errors.
/// [DEV] — Always includes a human-readable message and optional original error.
class AppException implements Exception {
  final String message;
  final Object? originalError;
  final String? code;

  const AppException({
    required this.message,
    this.originalError,
    this.code,
  });

  @override
  String toString() =>
      'AppException(message: $message, code: $code, originalError: $originalError)';
}

/// [DEV] — Network-related exceptions: no connectivity, timeout, DNS failure.
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.originalError,
    super.code,
  });
}

/// [DEV] — Server-side exceptions: 4xx, 5xx responses.
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    required super.message,
    this.statusCode,
    super.originalError,
    super.code,
  });

  @override
  String toString() =>
      'ServerException(statusCode: $statusCode, message: $message, code: $code)';
}

/// [DEV] — Cache-related exceptions: read/write failures, data corruption.
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.originalError,
    super.code,
  });
}

/// [DEV] — Location exceptions: permission denied, GPS unavailable, timeout.
class LocationException extends AppException {
  const LocationException({
    required super.message,
    super.originalError,
    super.code,
  });
}

/// [DEV] — Parse exceptions: JSON decode failures, missing fields, type mismatches.
class ParseException extends AppException {
  const ParseException({
    required super.message,
    super.originalError,
    super.code,
  });
}
