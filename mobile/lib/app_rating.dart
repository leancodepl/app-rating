import 'package:app_rating/widgets/single_answer_dialog/single_answer_dialog.dart';
import 'package:app_rating/widgets/star_dialog/rate_star_dialog.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => RateStarDialog(
        cqrs: cqrs,
        inAppReview: inAppReview,
        appleStoreId: appleStoreId,
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
    showDialog(
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
}
