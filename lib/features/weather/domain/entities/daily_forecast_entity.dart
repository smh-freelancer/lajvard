// [OWNER] — Daily forecast entity.
// [OWNER] — Contains 7 days of forecast data.
// [DEV] — Starts from TOMORROW, not today (Rule 13).

import 'package:flutter/material.dart';

import 'daily_item_entity.dart';

@immutable
class DailyForecastEntity {
  final List<DailyItemEntity> items;

  const DailyForecastEntity({required this.items});
}
