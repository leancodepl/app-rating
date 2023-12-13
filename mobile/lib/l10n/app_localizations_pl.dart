import 'app_localizations.dart';

/// The translations for Polish (`pl`).
class AppRatingLocalizationsPl extends AppRatingLocalizations {
  AppRatingLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get starDialogHeader => 'Oceń nas';

  @override
  String get starDialogSubtitle => 'Kliknij na gwiazdkę, aby ocenić';

  @override
  String get starDialogPrimaryButton => 'Wyślij';

  @override
  String get starDialogSecondaryButton => 'Anuluj';

  @override
  String get starDialogRateUsHeader => 'Dziękujemy!';

  @override
  String starDialogRateUsSubtitle(String store) {
    return 'Jeśli jesteś zadowolony/a z korzystania z naszej aplikacji, oceń nas w $store.';
  }

  @override
  String starDialogOpenStoreButton(String store) {
    return 'Oceń w $store';
  }

  @override
  String get starDialogOpenStoreCloseButton => 'Anuluj';

  @override
  String get textFieldHint => 'Jak oceniasz swoje doświadczenie?';

  @override
  String get singleAnswerDialogHeader => 'Czy jesteś zadowolony/a z aplikacji?';

  @override
  String get singleAnswerDialogPositiveButton => 'Tak';

  @override
  String get singleAnswerDialogNegativeButton => 'Nie';

  @override
  String get singleAnswerDialogCancelButton => 'Przypomnij mi później';

  @override
  String get singleAnswerDialogMoreInfoHeader => 'Pomóż nam stawać się lepszym';

  @override
  String get singleAnswerDialogMoreInfoPrimaryButton => 'Wyślij';

  @override
  String get singleAnswerDialogMoreInfoSecondaryButton => 'Anuluj';
}
