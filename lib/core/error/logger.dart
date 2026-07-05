// [OWNER] — Logging module. Records app events for debugging.
// [OWNER] — In release mode, only warnings and errors are logged.
// [DEV] — Singleton pattern: one logger instance across the entire app.
// [DEV] — Fully standalone: copy this file, import, call `AppLogger.instance`.

import 'dart:developer' as developer;

/// [DEV] — Log severity levels.
enum LogLevel {
  debug,
  info,
  warning,
  error,
}

/// [DEV] — Singleton logger. Wraps dart:developer.log with level filtering.
/// [DEV] — In release mode, debug and info messages are suppressed.
class AppLogger {
  // [DEV] — Singleton private constructor.
  AppLogger._();

  /// [DEV] — Singleton instance.
  static final AppLogger instance = AppLogger._();

  /// [DEV] — Set to false in release builds to suppress debug/info.
  bool _isDebugMode = true;

  /// [DEV] — Call this in main() to set the mode based on kDebugMode.
  void setDebugMode(bool isDebug) {
    _isDebugMode = isDebug;
  }

  /// [DEV] — Minimum level for output. In release: warning. In debug: debug.
  LogLevel get _minLevel => _isDebugMode ? LogLevel.debug : LogLevel.warning;

  bool _shouldLog(LogLevel level) {
    return level.index >= _minLevel.index;
  }

  /// [DEV] — Log a debug message. Only in debug mode.
  void debug(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(LogLevel.debug)) return;
    _log(
      LogLevel.debug,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// [DEV] — Log an info message. Only in debug mode.
  void info(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(LogLevel.info)) return;
    _log(
      LogLevel.info,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// [DEV] — Log a warning. Shown in both debug and release.
  void warning(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(LogLevel.warning)) return;
    _log(
      LogLevel.warning,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// [DEV] — Log an error. Always shown.
  void error(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.error,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void _log(
    LogLevel level,
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final levelTag = level.name.toUpperCase();
    final logName = name ?? 'Lajvard';
    developer.log(
      '[$levelTag] $message',
      name: logName,
      error: error,
      stackTrace: stackTrace,
      level: _levelToInt(level),
    );
  }

  /// [DEV] — Maps LogLevel to dart:developer log level (0=fine, 1000=severe).
  int _levelToInt(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
    }
  }
}
