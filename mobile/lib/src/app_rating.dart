import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:leancode_app_rating/src/widgets/single_answer_dialog/single_answer_dialog.dart';
import 'package:leancode_app_rating/src/widgets/star_dialog/rate_star_dialog.dart';
import 'package:leancode_app_rating/src/widgets/star_dialog/simple_rate_star_dialog.dart';
import 'package:leancode_contracts/leancode_contracts.dart';

class AppRating {
  AppRating({
    required this.cqrs,
    required this.appleStoreId,
    required this.appVersion,
  }) : inAppReview = InAppReview.instance;

  final Cqrs cqrs;
  final String appleStoreId;
  final InAppReview inAppReview;
  final String appVersion;

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
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => SimpleRateStarDialog(
        cqrs: cqrs,
        appleStoreId: appleStoreId,
        inAppReview: inAppReview,
        appVersion: appVersion,
        starDialogHeader: starDialogHeader,
        starDialogSubtitle: starDialogSubtitle,
        starDialogPrimaryButton: starDialogPrimaryButton,
        starDialogSecondaryButton: starDialogSecondaryButton,
        starDialogRateUsHeader: starDialogRateUsHeader,
        starDialogRateUsSubtitle: starDialogRateUsSubtitle,
        starDialogOpenStoreButton: starDialogOpenStoreButton,
        starDialogOpenStoreCloseButton: starDialogOpenStoreCloseButton,
      ),
    );
  }

  void showSingleAnswerDialog(
    BuildContext context, {
    String? singleAnswerDialogHeader,
    String? singleAnswerDialogPositiveButton,
    String? singleAnswerDialogNegativeButton,
    String? singleAnswerDialogCancelButton,
    String? singleAnswerDialogMoreInfoHeader,
    String? singleAnswerDialogMoreInfoPrimaryButton,
    String? singleAnswerDialogMoreInfoSecondaryButton,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => SingleAnswerDialog(
        cqrs: cqrs,
        inAppReview: inAppReview,
        appVersion: appVersion,
        singleAnswerDialogHeader: singleAnswerDialogHeader,
        singleAnswerDialogPositiveButton: singleAnswerDialogPositiveButton,
        singleAnswerDialogNegativeButton: singleAnswerDialogNegativeButton,
        singleAnswerDialogCancelButton: singleAnswerDialogCancelButton,
        singleAnswerDialogMoreInfoHeader: singleAnswerDialogMoreInfoHeader,
        singleAnswerDialogMoreInfoPrimaryButton:
            singleAnswerDialogMoreInfoPrimaryButton,
        singleAnswerDialogMoreInfoSecondaryButton:
            singleAnswerDialogMoreInfoSecondaryButton,
      ),
    );
  }

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
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => RateStarDialog(
        cqrs: cqrs,
        inAppReview: inAppReview,
        appleStoreId: appleStoreId,
        appVersion: appVersion,
        headerBuilder: headerBuilder,
        subtitleBuilder: subtitleBuilder,
        primaryButtonBuilder: primaryButtonBuilder,
        secondaryButtonBuilder: secondaryButtonBuilder,
        ratedHeaderBuilder: ratedHeaderBuilder,
        ratedSubtitleBuilder: ratedSubtitleBuilder,
        ratedPrimaryButtonBuilder: ratedPrimaryButtonBuilder,
        ratedSecondaryButtonBuilder: ratedSecondaryButtonBuilder,
        additionalCommentBuilder: additionalCommentBuilder,
        ratingBuilder: ratingBuilder,
        padding: padding,
      ),
    );
  }
}
