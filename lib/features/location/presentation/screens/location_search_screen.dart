// [OWNER] — Location search screen.
// [OWNER] — Allows user to search for a city or use their current GPS location.
// [DEV] — Uses AsyncValue search state so loading, empty, and error are distinct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/locale_service.dart';
import '../../domain/entities/location_entity.dart';
import '../providers/location_provider.dart';
import '../widgets/location_search_item.dart';

class LocationSearchScreen extends ConsumerStatefulWidget {
  const LocationSearchScreen({super.key});

  @override
  ConsumerState<LocationSearchScreen> createState() =>
      _LocationSearchScreenState();
}

class _LocationSearchScreenState extends ConsumerState<LocationSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isResolvingLocation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSelectLocation(LocationEntity location) {
    Navigator.of(context).pop(location);
  }

  Future<void> _onUseMyLocation() async {
    if (_isResolvingLocation) return;
    setState(() => _isResolvingLocation = true);
    try {
      final location = await ref.refresh(deviceLocationProvider.future);
      if (!mounted) return;
      Navigator.of(context).pop(location);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isResolvingLocation = false);
      }
    }
  }

  void _onQueryChanged(String query) {
    setState(() {});
    ref.read(citySearchProvider.notifier).onQueryChanged(query);
  }

  void _clearQuery() {
    _searchController.clear();
    setState(() {});
    ref.read(citySearchProvider.notifier).onQueryChanged('');
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final localeService =
        LocaleService(locale: Localizations.localeOf(context));
    final searchAsync = ref.watch(citySearchProvider);
    final hasQuery = _searchController.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        title: Text(localeService.convertDigits('Search Location')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              onChanged: _onQueryChanged,
              decoration: InputDecoration(
                hintText: localeService.convertDigits('Search city name...'),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: hasQuery
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _clearQuery,
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _isResolvingLocation ? null : _onUseMyLocation,
                icon: _isResolvingLocation
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location),
                label: Text(localeService.convertDigits('Use my location')),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: searchAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    localeService.convertDigits('Search failed: $error'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              data: (results) {
                if (!hasQuery) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        localeService.convertDigits(
                            'Search for a city or use your current location.'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (results.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        localeService.convertDigits('No cities found.'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final location = results[index];
                    return LocationSearchItem(
                      location: location,
                      onTap: () => _onSelectLocation(location),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
