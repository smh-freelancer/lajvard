// [OWNER] — Safe JSON parsing utilities.
// [OWNER] — Open-Meteo occasionally returns numbers as Strings.
// [DEV] — Moved here as public utilities so all data models can share them.
// [DEV] — Fully standalone: copy this file anywhere to handle dynamic JSON safely.

/// [DEV] — Safely parses a dynamic JSON value into a double.
/// [DEV] — Handles both `num` and `String` types without throwing.
double parseDouble(dynamic value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

/// [DEV] — Safely parses a dynamic JSON value into an int.
/// [DEV] — Handles `int`, `double`, and `String` types without throwing.
int parseInt(dynamic value) {
  if (value is int) return value;
  if (value is double) return value.round();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}
