// [OWNER] — Location entity.
// [OWNER] — Represents a city or geographic coordinate.
// [DEV] — Pure domain object. Used by both weather and location features.

import 'package:flutter/material.dart';

@immutable
class LocationEntity {
  final double latitude;
  final double longitude;
  final String name;
  final String country;
  final String? adminArea; // [DEV] — State/Province (e.g., "Tehran Province")

  const LocationEntity({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.country,
    this.adminArea,
  });

  /// [DEV] — Display string: "Tehran, Iran" or "Tehran, Tehran Province, Iran"
  String get displayName {
    if (adminArea != null && adminArea!.isNotEmpty) {
      return '$name, $adminArea, $country';
    }
    return '$name, $country';
  }
}
