// [OWNER] — Hourly forecast entity.
// [OWNER] — Contains a list of hourly weather data points.
// [DEV] — Only TODAY's remaining hours should be in this list (Rule 13).

import 'package:flutter/material.dart';

import 'hourly_item_entity.dart';

@immutable
class HourlyForecastEntity {
  final List<HourlyItemEntity> items;

  const HourlyForecastEntity({required this.items});
}
