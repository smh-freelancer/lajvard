// [OWNER] — Hourly forecast horizontal list.
// [OWNER] — Shows a scrollable row of hour-by-hour weather for the rest of today.
// [DEV] — Uses ListView.builder for performance (Rule 25).

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/locale_service.dart';
import '../providers/weather_providers.dart';
import 'hourly_item_card.dart';

class HourlyForecastList extends ConsumerWidget {
  const HourlyForecastList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hourly = ref.watch(hourlyForecastProvider);
    final localeService =
        LocaleService(locale: Localizations.localeOf(context));

    if (hourly == null || hourly.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            localeService.convertDigits(
              '⏱ Hourly Forecast',
            ), // [DEV] — Digits won't change here, but ensures consistency
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.9),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: hourly.items.length,
            itemBuilder: (context, index) {
              final item = hourly.items[index];
              return HourlyItemCard(item: item);
            },
          ),
        ),
      ],
    );
  }
}
