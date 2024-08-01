## Getting started

Add to localizationDelegates:
```
AppRatingLocalizations.localizationsDelegates
```

## Usage

```dart
final appRating = AppRating(cqrs: cqrs, appleStoreId: 'appleStoreId', appVersion: '1.0.0');


appRating.showSingleAnswerDialog(context);
appRating.showStarDialog(context);
```

## Additional information

You can replace texts in dialogs by passing them to the "showStarDialog, showSingleAnswerDialog" methods
