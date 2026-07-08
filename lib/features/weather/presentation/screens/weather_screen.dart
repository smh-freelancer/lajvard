// [OWNER] — Main weather screen.
// [OWNER] — Shows all weather data in the exact order specified in Rule 13.
// [DEV] — Updated with city search button and working refresh.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shimmer/shimmer_module.dart';
import '../../../location/domain/entities/location_entity.dart';
import '../providers/weather_provider.dart';
import '../widgets/current_weather_header.dart';
import '../widgets/daily_forecast_list.dart';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/weather_details_grid.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF0A1628),
        Color(0xFF162D50),
      ],
    );

    return Container(
      decoration: const BoxDecoration(gradient: gradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: weatherAsync.when(
            data: (_) => _buildContent(context, ref),
            loading: () => _buildLoading(context),
            error: (error, stackTrace) => _buildError(context, ref, error),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      color: const Color(0xFFD4A843),
      backgroundColor: const Color(0xFF162D50),
      onRefresh: () => ref.read(weatherProvider.notifier).refresh(),
      child: CustomScrollView(
        slivers: [
          // [DEV] — Search City Button
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    //onTap: () => context.push('/location-search'),
                    onTap: () async {
                      final picked = await context
                          .push<LocationEntity>('/location-search');
                      if (picked != null && context.mounted) {
                        await ref.read(weatherProvider.notifier).updateLocation(
                              picked.latitude,
                              picked.longitude,
                              picked.name,
                            );
                        await ref.read(weatherProvider.notifier).refresh();
                      }
                    },

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.manage_search,
                          color: Colors.white70,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Search City',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/settings'),
                    child: const Icon(
                      Icons.settings,
                      color: Colors.white70,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: CurrentWeatherHeader(),
            ),
          ),
          const SliverToBoxAdapter(child: HourlyForecastList()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const SliverToBoxAdapter(child: DailyForecastList()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          const SliverToBoxAdapter(child: WeatherDetailsGrid()),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return ShimmerModule.placeholder(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 48.0, left: 16, right: 16),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref, Object error) {
    String message = 'Something went wrong.';
    String subMessage = 'Please try again.';

    if (error is Exception) {
      final errStr = error.toString();
      if (errStr.contains('No internet') || errStr.contains('timed out')) {
        message = 'No Internet Connection';
        subMessage = 'Please check your network and try again.';
      } else if (errStr.contains('Server error')) {
        message = 'Server Error';
        subMessage = 'The weather service is unavailable right now.';
      } else if (errStr.contains('Location')) {
        message = 'Location Unavailable';
        subMessage = 'Could not get your location.';
      }
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off,
              size: 64,
              color: Colors.white.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subMessage,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white.withValues(alpha: 0.6)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref.read(weatherProvider.notifier).refresh(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A843),
                foregroundColor: const Color(0xFF0A1628),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
