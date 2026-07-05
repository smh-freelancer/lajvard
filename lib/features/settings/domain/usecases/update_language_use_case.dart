// [OWNER] — Use case: Change language.
// [DEV] — Changing language triggers locale, RTL/LTR, digit, and calendar switch.

import '../../../../core/error/failure.dart';
import '../repositories/settings_repository.dart';

class UpdateLanguageUseCase {
  final SettingsRepository repository;

  UpdateLanguageUseCase(this.repository);

  Future<Result<void>> call(String languageCode) {
    return repository.updateLanguage(languageCode);
  }
}
