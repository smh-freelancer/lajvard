// [OWNER] — Use case: Search for cities by name.
// [DEV] — Used by the location search screen.

import '../../../../core/error/failure.dart';
import '../entities/location_entity.dart';
import '../repositories/location_repository.dart';

class SearchCityUseCase {
  final LocationRepository repository;

  SearchCityUseCase(this.repository);

  Future<Result<List<LocationEntity>>> call(String query) {
    return repository.searchCity(query);
  }
}
