import 'package:leancode_app_rating/utils/platform_info.dart';
import 'package:leancode_app_rating/utils/strings.dart';
import 'package:leancode_app_rating/widgets/common/base_dialog.dart';
import 'package:leancode_app_rating/widgets/buttons/primary_button.dart';
import 'package:leancode_app_rating/widgets/buttons/secondary_button.dart';
import 'package:leancode_app_rating/widgets/common/feedback_text_field.dart';
import 'package:leancode_app_rating/widgets/common/loading_overlay.dart';
import 'package:leancode_app_rating/widgets/common/text_styles.dart';
import 'package:leancode_app_rating/widgets/star_dialog/rate_star_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:leancode_contracts/leancode_contracts.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class RateStarDialog extends HookWidget {
  const RateStarDialog({
    super.key,
    required this.cqrs,
    required this.inAppReview,
    required this.appleStoreId,
    required this.appVersion,
    this.starDialogHeader,
    this.starDialogSubtitle,
    this.starDialogPrimaryButton,
    this.starDialogSecondaryButton,
    this.starDialogRateUsHeader,
    this.starDialogRateUsSubtitle,
    this.starDialogOpenStoreButton,
    this.starDialogOpenStoreCloseButton,
  });

  final Cqrs cqrs;
  final InAppReview inAppReview;
  final String appleStoreId;
  final String appVersion;
  final String? starDialogHeader;
  final String? starDialogSubtitle;
  final String? starDialogPrimaryButton;
  final String? starDialogSecondaryButton;
  final String? starDialogRateUsHeader;
  final String? starDialogRateUsSubtitle;
  final String? starDialogOpenStoreButton;
  final String? starDialogOpenStoreCloseButton;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    final rateCubit = useBloc<RatingCubit>(
      () => RatingCubit(
        cqrs: cqrs,
        inAppReview: inAppReview,
        appStoreId: appleStoreId,
        appVersion: appVersion,
      ),
    );

    useOnStreamChange(rateCubit.presentation, onData: (event) {
      if (event is CloseDialogEvent) {
        Navigator.of(context).pop();
      }
    });

    final textController = useTextEditingController();

    return BaseDialog(
      child: BlocBuilder<RatingCubit, RatingState>(
        bloc: rateCubit,
        builder: (context, state) {
          if (state.rateUs) {
            return RateUsInStore(
              rateCubit: rateCubit,
              starDialogOpenStoreButton: starDialogOpenStoreButton,
              starDialogOpenStoreCloseButton: starDialogOpenStoreCloseButton,
              starDialogRateUsHeader: starDialogRateUsHeader,
              starDialogRateUsSubtitle: starDialogRateUsSubtitle,
            );
          }
          return AppLoadingOverlay(
            isLoading: state.inProgress,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    starDialogHeader ?? s.starDialogHeader,
                    softWrap: true,
                    style: headerStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    starDialogSubtitle ?? s.starDialogSubtitle,
                    style: subtitleTextStyle,
                  ),
                  const SizedBox(height: 24),
                  RatingStars(ratingCubit: rateCubit),
                  const SizedBox(height: 24),
                  if (state.expanded)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: FeedbackTextField(
                        textController: textController,
                      ),
                    ),
                  PrimaryButton(
                    label: starDialogPrimaryButton ?? s.starDialogPrimaryButton,
                    onPressed: () {
                      rateCubit.submit(
                        additionalComment: textController.text,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  SecondaryButton(
                    label: starDialogSecondaryButton ??
                        s.starDialogSecondaryButton,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RateUsInStore extends StatelessWidget {
  const RateUsInStore({
    super.key,
    required this.rateCubit,
    this.starDialogRateUsHeader,
    this.starDialogRateUsSubtitle,
    this.starDialogOpenStoreButton,
    this.starDialogOpenStoreCloseButton,
  });

  final RatingCubit rateCubit;
  final String? starDialogRateUsHeader;
  final String? starDialogRateUsSubtitle;
  final String? starDialogOpenStoreButton;
  final String? starDialogOpenStoreCloseButton;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            starDialogRateUsHeader ?? s.starDialogRateUsHeader,
            softWrap: true,
            style: headerStyle,
          ),
          const SizedBox(height: 8),
          Text(
            starDialogRateUsSubtitle ??
                s.starDialogRateUsSubtitle(getStoreName),
            textAlign: TextAlign.center,
            style: subtitleTextStyle,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: starDialogOpenStoreButton ??
                s.starDialogOpenStoreButton(getStoreName),
            onPressed: rateCubit.openStore,
          ),
          const SizedBox(height: 8),
          SecondaryButton(
            label: starDialogOpenStoreCloseButton ??
                s.starDialogOpenStoreCloseButton,
            onPressed: Navigator.of(context).pop,
          ),
        ],
      ),
    );
  }
}

class RatingStars extends StatelessWidget {
  const RatingStars({Key? key, required this.ratingCubit}) : super(key: key);

  final RatingCubit ratingCubit;

  @override
  Widget build(BuildContext context) {
    const selectedStar = Image(
      image: AssetImage(
        'packages/app_rating/assets/star-selected.png',
      ),
    );

    const unSelectedStar = Image(
      image: AssetImage(
        'packages/app_rating/assets/star-unselected.png',
      ),
    );

    return BlocBuilder<RatingCubit, RatingState>(
      bloc: ratingCubit,
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (index) {
              return GestureDetector(
                onTap: () {
                  ratingCubit.setRating(index + 1);
                },
                child: Padding(
                  padding: index < 5
                      ? const EdgeInsets.only(right: 24)
                      : EdgeInsets.zero,
                  child: state.rating > index ? selectedStar : unSelectedStar,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
