# app_rating

<img width="300" alt="image" src="https://github.com/user-attachments/assets/f5d48083-7f18-4a1d-9a5d-82d3f862f3cd">
<img width="300" alt="image" src="https://github.com/user-attachments/assets/0ba3321e-39fb-4f9b-94ee-6e7cbca1fe98">
<img width="300" alt="image" src="https://github.com/user-attachments/assets/b7d40e4e-cf22-4199-9240-2f690357e5f5">

## Description

This feature provides out-of-the-box support for collecting direct feedback from users. Feedback can be gathered through two methods:

- **Five star rating with optional comment:** Users can provide a rating on a 1-5 star scale, accompanied by an optional comment.
- **Yes/No Satisfaction:** Users can answer a simple yes/no question regarding their overall satisfaction with the application.

If the user provides a positive review, they will be kindly asked to rate the application on the app store. In addition to the feedback, OS and mobile device parameters are automatically stored in the backend for analytics purposes. 

## Usage

### Setup

Initialize `AppRating` instace with:
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

### Yes/No dialog

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

### Five star rating dialog

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

## Team

@lukaszgarstecki
@denis-lncd
