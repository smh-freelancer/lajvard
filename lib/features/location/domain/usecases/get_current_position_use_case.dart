// [OWNER] — Use case: Get device's current GPS location.
// [DEV] — Lazy: doesn't request permission until this is called (Rule 25).

import '../../../../core/error/failure.dart';
import '../entities/location_entity.dart';
import '../repositories/location_repository.dart';

class GetCurrentPositionUseCase {
  final LocationRepository repository;

  GetCurrentPositionUseCase(this.repository);

  Future<Result<LocationEntity>> call() {
    return repository.getCurrentPosition();
  }
}
