import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppRatingLocalizations
/// returned by `AppRatingLocalizations.of(context)`.
///
/// Applications need to include `AppRatingLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppRatingLocalizations.localizationsDelegates,
///   supportedLocales: AppRatingLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppRatingLocalizations.supportedLocales
/// property.
abstract class AppRatingLocalizations {
  AppRatingLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppRatingLocalizations of(BuildContext context) {
    return Localizations.of<AppRatingLocalizations>(
        context, AppRatingLocalizations)!;
  }

  static const LocalizationsDelegate<AppRatingLocalizations> delegate =
      _AppRatingLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @starDialogHeader.
  ///
  /// In en, this message translates to:
  /// **'Rate us'**
  String get starDialogHeader;

  /// No description provided for @starDialogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap a star to rate'**
  String get starDialogSubtitle;

  /// No description provided for @starDialogPrimaryButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get starDialogPrimaryButton;

  /// No description provided for @starDialogSecondaryButton.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get starDialogSecondaryButton;

  /// No description provided for @starDialogRateUsHeader.
  ///
  /// In en, this message translates to:
  /// **'Thank you!'**
  String get starDialogRateUsHeader;

  /// No description provided for @starDialogRateUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'If you enjoy using this app, rate it in the {store}.'**
  String starDialogRateUsSubtitle(String store);

  /// No description provided for @starDialogOpenStoreButton.
  ///
  /// In en, this message translates to:
  /// **'Rate in the {store}'**
  String starDialogOpenStoreButton(String store);

  /// No description provided for @starDialogOpenStoreCloseButton.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get starDialogOpenStoreCloseButton;

  /// No description provided for @textFieldHint.
  ///
  /// In en, this message translates to:
  /// **'How was your experience ?'**
  String get textFieldHint;

  /// No description provided for @singleAnswerDialogHeader.
  ///
  /// In en, this message translates to:
  /// **'Are you enjoying this app?'**
  String get singleAnswerDialogHeader;

  /// No description provided for @singleAnswerDialogPositiveButton.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get singleAnswerDialogPositiveButton;

  /// No description provided for @singleAnswerDialogNegativeButton.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get singleAnswerDialogNegativeButton;

  /// No description provided for @singleAnswerDialogCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Remind me later'**
  String get singleAnswerDialogCancelButton;

  /// No description provided for @singleAnswerDialogMoreInfoHeader.
  ///
  /// In en, this message translates to:
  /// **'Help us improve'**
  String get singleAnswerDialogMoreInfoHeader;

  /// No description provided for @singleAnswerDialogMoreInfoPrimaryButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get singleAnswerDialogMoreInfoPrimaryButton;

  /// No description provided for @singleAnswerDialogMoreInfoSecondaryButton.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get singleAnswerDialogMoreInfoSecondaryButton;
}

class _AppRatingLocalizationsDelegate
    extends LocalizationsDelegate<AppRatingLocalizations> {
  const _AppRatingLocalizationsDelegate();

  @override
  Future<AppRatingLocalizations> load(Locale locale) {
    return SynchronousFuture<AppRatingLocalizations>(
        lookupAppRatingLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppRatingLocalizationsDelegate old) => false;
}

AppRatingLocalizations lookupAppRatingLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppRatingLocalizationsEn();
    case 'pl':
      return AppRatingLocalizationsPl();
  }

  throw FlutterError(
      'AppRatingLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
