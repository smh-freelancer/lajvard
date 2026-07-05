// [OWNER] — Use case: Read current user settings.
// [DEV] — Returns the combined SettingsState.

import '../../../../core/error/failure.dart';

import '../repositories/settings_repository.dart';

// [DEV] — Re-export SettingsState so presentation layer doesn't need to import repository.
// [DEV] — In Dart, this is a simple re-export.
export '../repositories/settings_repository.dart' show SettingsState;

class GetSettingsUseCase {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  Future<Result<SettingsState>> call() {
    return repository.getSettings();
  }
}
