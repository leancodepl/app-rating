import 'package:cqrs/cqrs.dart';
import 'package:flutter/widgets.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:leancode_app_rating/src/l10n/app_localizations.dart';
import 'package:leancode_app_rating/src/utils/platform_info.dart';
import 'package:leancode_app_rating/src/widgets/buttons/primary_button.dart';
import 'package:leancode_app_rating/src/widgets/buttons/secondary_button.dart';
import 'package:leancode_app_rating/src/widgets/common/feedback_text_field.dart';
import 'package:leancode_app_rating/src/widgets/common/text_styles.dart';
import 'package:leancode_app_rating/src/widgets/star_dialog/rate_star_dialog.dart';

class SimpleRateStarDialog extends StatelessWidget {
  const SimpleRateStarDialog({
    super.key,
    required this.cqrs,
    required this.appleStoreId,
    required this.inAppReview,
    required this.appVersion,
    this.starDialogHeader,
    this.starDialogSubtitle,
    this.starDialogPrimaryButton,
    this.starDialogSecondaryButton,
    this.starDialogRateUsHeader,
    this.starDialogRateUsSubtitle,
    this.starDialogOpenStoreButton,
    this.starDialogOpenStoreCloseButton,
    this.backgroundColor,
  });

  final Cqrs cqrs;
  final String appleStoreId;
  final InAppReview inAppReview;
  final String appVersion;
  final String? starDialogHeader;
  final String? starDialogSubtitle;
  final String? starDialogPrimaryButton;
  final String? starDialogSecondaryButton;
  final String? starDialogRateUsHeader;
  final String? starDialogRateUsSubtitle;
  final String? starDialogOpenStoreButton;
  final String? starDialogOpenStoreCloseButton;

  /// The dialog's background color. Defaults to the dialog theme's background
  /// color.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final s = AppRatingLocalizations.of(context);

    return RateStarDialog(
      cqrs: cqrs,
      inAppReview: inAppReview,
      appleStoreId: appleStoreId,
      appVersion: appVersion,
      padding: const EdgeInsets.all(24),
      backgroundColor: backgroundColor,
      headerBuilder: (context, _) => Text(
        starDialogHeader ?? s.starDialogHeader,
        softWrap: true,
        style: headerStyle,
      ),
      subtitleBuilder: (context, _) => Text(
        starDialogSubtitle ?? s.starDialogSubtitle,
        style: subtitleTextStyle,
      ),
      primaryButtonBuilder: (context, _, {required onPressed}) => PrimaryButton(
        label: starDialogPrimaryButton ?? s.starDialogPrimaryButton,
        onPressed: onPressed,
      ),
      secondaryButtonBuilder: (context, _, {required onPressed}) =>
          SecondaryButton(
            label: starDialogSecondaryButton ?? s.starDialogSecondaryButton,
            onPressed: Navigator.of(context).pop,
          ),
      ratedHeaderBuilder: (context, rating) => Text(
        starDialogRateUsHeader ?? s.starDialogRateUsHeader,
        softWrap: true,
        style: headerStyle,
      ),
      ratedSubtitleBuilder: (context, rating) => Text(
        starDialogRateUsSubtitle ?? s.starDialogRateUsSubtitle(getStoreName),
        textAlign: TextAlign.center,
        style: subtitleTextStyle,
      ),
      ratedPrimaryButtonBuilder: (context, rating, {required onPressed}) =>
          PrimaryButton(
            label:
                starDialogOpenStoreButton ??
                s.starDialogOpenStoreButton(getStoreName),
            onPressed: onPressed,
          ),
      ratedSecondaryButtonBuilder: (context, rating, {required onPressed}) =>
          SecondaryButton(
            label:
                starDialogOpenStoreCloseButton ??
                s.starDialogOpenStoreCloseButton,
            onPressed: Navigator.of(context).pop,
          ),
      additionalCommentBuilder: (_, _, controller) =>
          FeedbackTextField(textController: controller),
      ratingBuilder: (_, rating, {required onChanged}) =>
          _RatingStars(value: rating, onChanged: onChanged),
    );
  }
}

class _RatingStars extends StatelessWidget {
  const _RatingStars({required this.value, required this.onChanged});

  final ValueChanged<int> onChanged;
  final int value;

  static const _starsCount = 5;

  @override
  Widget build(BuildContext context) {
    const selectedStar = Image(
      image: AssetImage(
        'packages/leancode_app_rating/assets/star-selected.png',
      ),
    );
    const unSelectedStar = Image(
      image: AssetImage(
        'packages/leancode_app_rating/assets/star-unselected.png',
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_starsCount, (index) {
        return GestureDetector(
          onTap: () => onChanged(index + 1),
          child: Padding(
            padding: index < _starsCount - 1
                ? const EdgeInsets.only(right: 24)
                : EdgeInsets.zero,
            child: value > index ? selectedStar : unSelectedStar,
          ),
        );
      }),
    );
  }
}
