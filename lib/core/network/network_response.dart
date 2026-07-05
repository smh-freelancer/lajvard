// [OWNER] — Typed network response wrapper.
// [OWNER] — Represents either a successful HTTP response or an HTTP failure.
// [DEV] — Decouples the network layer from the domain layer.
// [DEV] — Fully standalone: copy this file, import, use as return type.

/// [DEV] — Sealed class to ensure exhaustive handling of network results.
sealed class NetworkResponse<T> {
  const NetworkResponse();
}

/// [DEV] — Represents a successful HTTP response.
class ApiResponseSuccess<T> extends NetworkResponse<T> {
  final T data;
  final int statusCode;

  const ApiResponseSuccess({
    required this.data,
    required this.statusCode,
  });
}

/// [DEV] — Represents an HTTP failure (timeout, no internet, 4xx, 5xx).
class ApiResponseFailure<T> extends NetworkResponse<T> {
  final String message;
  final int? statusCode;
  final Object? originalError;

  const ApiResponseFailure({
    required this.message,
    this.statusCode,
    this.originalError,
  });
}
