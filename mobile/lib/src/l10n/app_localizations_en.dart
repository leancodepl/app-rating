import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppRatingLocalizationsEn extends AppRatingLocalizations {
  AppRatingLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get starDialogHeader => 'Rate us';

  @override
  String get starDialogSubtitle => 'Tap a star to rate';

  @override
  String get starDialogPrimaryButton => 'Send';

  @override
  String get starDialogSecondaryButton => 'Dismiss';

  @override
  String get starDialogRateUsHeader => 'Thank you!';

  @override
  String starDialogRateUsSubtitle(String store) {
    return 'If you enjoy using this app, rate it in the $store.';
  }

  @override
  String starDialogOpenStoreButton(String store) {
    return 'Rate in the $store';
  }

  @override
  String get starDialogOpenStoreCloseButton => 'Dismiss';

  @override
  String get textFieldHint => 'How was your experience ?';

  @override
  String get singleAnswerDialogHeader => 'Are you enjoying this app?';

  @override
  String get singleAnswerDialogPositiveButton => 'Yes';

  @override
  String get singleAnswerDialogNegativeButton => 'No';

  @override
  String get singleAnswerDialogCancelButton => 'Remind me later';

  @override
  String get singleAnswerDialogMoreInfoHeader => 'Help us improve';

  @override
  String get singleAnswerDialogMoreInfoPrimaryButton => 'Send';

  @override
  String get singleAnswerDialogMoreInfoSecondaryButton => 'Dismiss';
}
