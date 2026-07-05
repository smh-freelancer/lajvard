// [OWNER] — Use case: Change temperature unit.
// [DEV] — Strategy pattern for conversion logic is in the enum extension.

import '../../../../core/error/failure.dart';
import '../entities/temperature_unit.dart';
import '../repositories/settings_repository.dart';

class UpdateTemperatureUnitUseCase {
  final SettingsRepository repository;

  UpdateTemperatureUnitUseCase(this.repository);

  Future<Result<void>> call(TemperatureUnit unit) {
    return repository.updateTemperatureUnit(unit);
  }
}
