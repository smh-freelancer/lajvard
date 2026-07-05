// [OWNER] — Failure type used by use cases to return errors.
// [OWNER] — This keeps the domain layer clean — no exceptions leak upward.
// [DEV] — Pattern similar to fpdart's Either<Failure, T> but custom and zero-dependency.
// [DEV] — Fully standalone: copy this file, import, use in any use case.

import 'package:flutter/material.dart';

/// [DEV] — Base failure class. Immutable, with a user-friendly message.
sealed class Failure {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  /// [DEV] — Convenience: user-friendly display message.
  String get displayMessage => message;
}

/// [DEV] — Network failure: no connectivity, timeout.
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection. Please check your network.',
    super.code,
  });
}

/// [DEV] — Server failure: API returned an error.
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({
    super.message = 'Server error. Please try again later.',
    this.statusCode,
    super.code,
  });
}

/// [DEV] — Cache failure: local storage read/write error.
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Local storage error. Please try again.',
    super.code,
  });
}

/// [DEV] — Location failure: permission denied or GPS unavailable.
class LocationFailure extends Failure {
  const LocationFailure({
    super.message = 'Could not get your location. Please check permissions.',
    super.code,
  });
}

/// [DEV] — Parse failure: data could not be decoded.
class ParseFailure extends Failure {
  const ParseFailure({
    super.message = 'Data format error. Please try again.',
    super.code,
  });
}

/// [DEV] — Unknown/unexpected failure.
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unexpected error occurred.',
    super.code,
  });
}

/// [DEV] — Result type: wraps either a success value or a Failure.
/// [DEV] — Replaces exceptions in use case returns.
/// [DEV] — Usage: `Result<WeatherEntity> result = await useCase.call();`
@immutable
class Result<T> {
  final T? _value;
  final Failure? _failure;

  const Result._({T? value, Failure? failure})
      : _value = value,
        _failure = failure;

  /// [DEV] — Creates a successful result.
  factory Result.success(T value) => Result._(value: value);

  /// [DEV] — Creates a failure result.
  factory Result.failure(Failure failure) => Result._(failure: failure);

  /// [DEV] — True if this is a success.
  bool get isSuccess => _failure == null;

  /// [DEV] — True if this is a failure.
  bool get isFailure => _failure != null;

  /// [DEV] — The success value. Throws if accessed on a failure.
  T get value {
    if (_failure != null) {
      throw StateError(
        'Cannot access value on a failed Result. Failure: $_failure',
      );
    }
    return _value as T;
  }

  /// [DEV] — The failure. Returns null on success.
  Failure? get failure => _failure;

  /// [DEV] — Pattern matching: execute one of two callbacks based on result type.
  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  }) {
    if (_failure != null) {
      return failure(_failure!);
    }
    return success(_value as T);
  }

  /// [DEV] — Map the success value to a new type. Failure passes through.
  Result<U> map<U>(U Function(T value) transform) {
    if (_failure != null) {
      return Result<U>.failure(_failure!);
    }
    return Result<U>.success(transform(_value as T));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Result<T> &&
        other._value == _value &&
        other._failure == _failure;
  }

  @override
  int get hashCode => Object.hash(_value, _failure);

  @override
  String toString() {
    if (_failure != null) {
      return 'Result.failure($_failure)';
    }
    return 'Result.success($_value)';
  }
}
