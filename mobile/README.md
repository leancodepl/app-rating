# leancode_app_rating

[![pub.dev badge][pub-badge]][pub-badge-link]
[![][leancode_app_rating-build-badge]][leancode_app_rating-build-badge-link]   

#### Setup

Add `AppRatingLocalizations` to your localizations delegates in `MaterialApp`:
```dart
  localizationsDelegates: const [
    (...)
    ...AppRatingLocalizations.localizationsDelegates,
  ],
```

Initialize `AppRating` instance with:
- your `cqrs`
- your app's AppStore ID (ex. `apps.apple.com/us/app/example/id000000000`)
- app version tag (`CFBundleShortVersionString` on iOS, `versionName` on Android). Feel free to use the [package_info_plus](https://pub.dev/packages/package_info_plus) for getting this value.

```dart
final rateApp = AppRating(
  cqrs: cqrs,
  appleStoreId: '111111',
  appVersion: packageInfo.version,
);
```

then provide it globally with `Provider` and use wherever you want to.

#### Yes/No dialog

```dart
void showSingleAnswerDialog(
  BuildContext context, {
  String? singleAnswerDialogHeader,
  String? singleAnswerDialogPositiveButton,
  String? singleAnswerDialogNegativeButton,
  String? singleAnswerDialogCancelButton,
  String? singleAnswerDialogMoreInfoHeader,
  String? singleAnswerDialogMoreInfoPrimaryButton,
  String? singleAnswerDialogMoreInfoSecondaryButton,
})
```

A dialog box is displayed, presenting the user with a `Yes` or `No` option to answer whether they like the application. The user's response is mapped as follows:
- Selecting `Yes` sends a value of 5 to the backend.
- Selecting `No` sends a value of 0 to the backend.

Upon selecting Yes, the `requestReview` function from the [in_app_review](https://pub.dev/packages/in_app_review) package is invoked in the background. This function attempts to display the app review dialog from the app store.

**WARNING:** The review dialog is not guaranteed to appear, as its display is controlled by the OS.

#### Five star rating dialog

```dart
void showStarDialog(
  BuildContext context, {
  String? starDialogHeader,
  String? starDialogSubtitle,
  String? starDialogPrimaryButton,
  String? starDialogSecondaryButton,
  String? starDialogRateUsHeader,
  String? starDialogRateUsSubtitle,
  String? starDialogOpenStoreButton,
  String? starDialogOpenStoreCloseButton,
})
```

The showStarDialog function displays a dialog box allowing the user to provide a star rating. If the user rates the app with fewer than 5 stars, the dialog expands to include a text field for additional comments. For high ratings (5 stars), the dialog changes its appearance by showing a button that directs the user to the app store to submit a review.

#### Customizable five star rating dialog

```dart
 void showCustomizableStarDialog(
BuildContext context, {
required WidgetBuilder headerBuilder,
required WidgetBuilder subtitleBuilder,
required ButtonBuilder primaryButtonBuilder,
required ButtonBuilder secondaryButtonBuilder,
required RatedWidgetBuilder ratedHeaderBuilder,
required RatedWidgetBuilder ratedSubtitleBuilder,
required RatedButtonBuilder ratedPrimaryButtonBuilder,
required RatedButtonBuilder ratedSecondaryButtonBuilder,
required TextFieldBuilder additionalCommentBuilder,
required RatingBuilder ratingBuilder,
EdgeInsets padding = EdgeInsets.zero,
})
```
The showCustomizableStarDialog function enables customization of the star rating flow. Texts, buttons, the text field for additional comments, and the rating widget are all fully customizable.

To replicate the behavior of the showStarDialog function, ensure that you call the onPressed functions for the button builders. In this flow, all secondary buttons terminate the rating process and close the dialog. The primary buttons have distinct behaviors: the primary button in the first dialog leads the user to the second dialog, while the primary button in the second dialog redirects the user to the app store to submit a review.

[pub-badge]: https://img.shields.io/pub/v/leancode_app_rating.svg?logo=dart

[pub-badge-link]: https://pub.dev/packages/leancode_app_rating

[leancode_app_rating-build-badge]: https://img.shields.io/github/actions/workflow/status/leancodepl/app-rating/leancode_app_rating-test.yml?branch=main

[leancode_app_rating-build-badge-link]: https://github.com/leancodepl/app-rating/actions/workflows/leancode_app_rating-test.yml
