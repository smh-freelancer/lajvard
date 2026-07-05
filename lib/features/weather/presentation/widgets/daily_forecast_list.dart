// [OWNER] — Daily forecast vertical list.
// [OWNER] — Shows 7 days of weather starting from tomorrow.
// [DEV] — Uses ListView.builder (Rule 25).

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/locale_service.dart';
import '../providers/weather_providers.dart';
import 'daily_item_row.dart';

class DailyForecastList extends ConsumerWidget {
  const DailyForecastList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final daily = ref.watch(dailyForecastProvider);
    final localeService =
        LocaleService(locale: Localizations.localeOf(context));

    if (daily == null || daily.items.isEmpty) {
      return const SizedBox.shrink();
    }

    // [DEV] — Calculate overall min/max for the temperature bar normalization
    double overallMin = double.infinity;
    double overallMax = double.negativeInfinity;
    for (var item in daily.items) {
      if (item.minTemperatureCelsius < overallMin) {
        overallMin = item.minTemperatureCelsius;
      }
      if (item.maxTemperatureCelsius > overallMax) {
        overallMax = item.maxTemperatureCelsius;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            localeService.convertDigits('📅 7-Day Forecast'),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.9),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(), // [DEV] — Main scroll handles it
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: daily.items.length,
          itemBuilder: (context, index) {
            return DailyItemRow(
              item: daily.items[index],
              overallMin: overallMin,
              overallMax: overallMax,
            );
          },
        ),
      ],
    );
  }
}
