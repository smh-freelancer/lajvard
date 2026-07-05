// [OWNER] — Use case: Change theme mode.
// [DEV] — Instant switching with no flicker.

import '../../../../core/error/failure.dart';
import '../entities/theme_mode_enum.dart';
import '../repositories/settings_repository.dart';

class UpdateThemeUseCase {
  final SettingsRepository repository;

  UpdateThemeUseCase(this.repository);

  Future<Result<void>> call(AppThemeMode mode) {
    return repository.updateThemeMode(mode);
  }
}
