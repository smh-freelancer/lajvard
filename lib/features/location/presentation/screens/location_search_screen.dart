// [OWNER] — Location search screen.
// [OWNER] — Allows user to search for a city or use their current GPS location.
// [DEV] — Uses the citySearchProvider for debounced API calls.
// [DEV] — Fixed: Removed `ref` from build() signature for Flutter 3.44+ compatibility.

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
    context.pop(location);
  }

  Future<void> _onUseMyLocation() async {
    final deviceLocation = ref.read(deviceLocationProvider);

    LocationEntity? location;
    if (deviceLocation.value case LocationEntity loc?) {
      location = loc;
    } else {
      location = await ref.read(deviceLocationProvider.future);
    }

    if (location != null && mounted) {
      context.pop(location);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Could not get location.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // [DEV] — No `WidgetRef ref` here in Flutter 3.44+
    final localeService = LocaleService(
      locale: Localizations.localeOf(context),
    );
    final searchResults = ref.watch(citySearchProvider);
    final isSearching =
        _searchController.text.isNotEmpty && searchResults.isEmpty;
    final deviceLocationAsync = ref.watch(deviceLocationProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(localeService.convertDigits('Search Location')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              onChanged: (query) {
                ref.read(citySearchProvider.notifier).onQueryChanged(query);
              },
              decoration: InputDecoration(
                hintText: localeService.convertDigits('Search city name...'),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          ref
                              .read(citySearchProvider.notifier)
                              .onQueryChanged('');
                          FocusScope.of(context).requestFocus();
                        },
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
                onPressed: deviceLocationAsync.isLoading
                    ? null
                    : _onUseMyLocation,
                icon: deviceLocationAsync.isLoading
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
          if (isSearching)
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          if (!isSearching)
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return LocationSearchItem(
                    location: searchResults[index],
                    onTap: () => _onSelectLocation(searchResults[index]),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
