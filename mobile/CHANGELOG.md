## 0.0.9

All six builders of the star dialog's first step now receive the currently selected rating, so neither your code nor `SimpleRateStarDialog` has to keep a copy of it. **Breaking:** each of them takes an extra positional `int`, `TextFieldBuilder` takes it before the controller, and `headerBuilder`/`subtitleBuilder` are now `RatedWidgetBuilder`s.

## 0.0.8

Upgraded `leancode_contracts` to `^0.10.0` and regenerated the contracts. **Breaking:** requires Dart 3.9 and Flutter 3.35.

## 0.0.7

Upgraded `equatable` and `leancode_contracts` to `^0.9.0`, and regenerated the contracts.

## 0.0.6

Fixed the star images not showing up — they still pointed at the package's old `app_rating` name.

## 0.0.5

Upgraded Flutter and dependencies, `intl` to `^0.20.2` among them. **Breaking:** requires Dart 3.8 and Flutter 3.32.

## 0.0.4

Dropped `freezed` in favour of `equatable`, and upgraded the remaining dependencies, `flutter_bloc` to `^9.1.0` and `leancode_hooks` to `^0.1.1` among them.

## 0.0.3

Added `showCustomizableStarDialog`, which takes a builder for every part of the star rating flow, and moved the stock look into `SimpleRateStarDialog`.

## 0.0.2

**Breaking:** the barrel file is now `leancode_app_rating.dart` instead of `rating.dart`, and the implementation moved under `src/`.

## 0.0.1+1

README only.

## 0.0.1

Initial release: `AppRating.showStarDialog` and `AppRating.showSingleAnswerDialog`, both submitting the rating over CQRS, asking for a store review on a positive one and for a comment on a negative one.
