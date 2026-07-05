// [OWNER] — Network client module. Handles all HTTP requests.
// [OWNER] — Wraps Dio with proper timeout, error handling, and logging.
// [DEV] — Fully standalone: copy this file + network_config.dart + network_response.dart.
// [DEV] — Uses Dio for interceptors, timeout config, and cancellation support.

import 'package:dio/dio.dart';
import '../error/logger.dart';
import 'network_config.dart';
import 'network_response.dart';

/// [DEV] — Network client. Initialized once with a config.
class NetworkClient {
  late final Dio _dio;
  final NetworkConfig config;

  NetworkClient({required this.config}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: config.connectTimeout,
        receiveTimeout: config.receiveTimeout,
        sendTimeout: config.sendTimeout,
        headers: config.defaultHeaders,
      ),
    );

    // [DEV] — Add logging interceptor.
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          AppLogger.instance.debug(
            '→ ${options.method} ${options.uri}',
            name: 'Network',
          );
          handler.next(options);
        },
        onResponse: (response, handler) {
          AppLogger.instance.debug(
            '← ${response.statusCode} ${response.requestOptions.uri}',
            name: 'Network',
          );
          handler.next(response);
        },
        onError: (error, handler) {
          AppLogger.instance.error(
            '✗ ${error.message}',
            name: 'Network',
            error: error,
          );
          handler.next(error);
        },
      ),
    );
  }

  /// [DEV] — GET request. Returns a typed NetworkResponse.
  Future<NetworkResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic data)? fromJson,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data == null) {
          return ApiResponseFailure<T>(message: 'Empty response body');
        }

        final parsed = fromJson != null ? fromJson(data) : data as T;
        return ApiResponseSuccess<T>(
          data: parsed,
          statusCode: response.statusCode ?? 200,
        );
      } else {
        return ApiResponseFailure<T>(
          message: 'Server error: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return ApiResponseFailure<T>(
        message: _mapDioError(e),
        statusCode: e.response?.statusCode,
        originalError: e,
      );
    } catch (e) {
      return ApiResponseFailure<T>(
        message: 'An unexpected error occurred',
        originalError: e,
      );
    }
  }

  /// [DEV] — Maps DioException to user-friendly messages.
  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.badResponse:
        return 'Server returned an error (${e.response?.statusCode}).';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      default:
        return 'Network error: ${e.message}';
    }
  }
}
