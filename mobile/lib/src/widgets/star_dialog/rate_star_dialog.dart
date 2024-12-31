import 'package:leancode_app_rating/src/package_name.dart';
import 'package:leancode_app_rating/src/utils/platform_info.dart';
import 'package:leancode_app_rating/src/utils/strings.dart';
import 'package:leancode_app_rating/src/widgets/common/base_dialog.dart';
import 'package:leancode_app_rating/src/widgets/buttons/primary_button.dart';
import 'package:leancode_app_rating/src/widgets/buttons/secondary_button.dart';
import 'package:leancode_app_rating/src/widgets/common/feedback_text_field.dart';
import 'package:leancode_app_rating/src/widgets/common/loading_overlay.dart';
import 'package:leancode_app_rating/src/widgets/common/text_styles.dart';
import 'package:leancode_app_rating/src/widgets/star_dialog/rate_star_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:leancode_contracts/leancode_contracts.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

typedef ButtonBuilder = Widget Function(
  BuildContext context, {
  required VoidCallback onPressed,
});

typedef TextFieldBuilder = Widget Function(
  BuildContext context,
  TextEditingController textController,
);

typedef RatingBuilder = Widget Function(
  BuildContext context, {
  required ValueChanged<int> onChanged,
});

typedef RatedWidgetBuilder = Widget Function(
  BuildContext context,
  int rating,
);

typedef RatedButtonBuilder = Widget? Function(
  BuildContext context,
  int rating, {
  required VoidCallback onPressed,
});

class RateStarDialog extends HookWidget {
  const RateStarDialog({
    super.key,
    required this.cqrs,
    required this.inAppReview,
    required this.appleStoreId,
    required this.appVersion,
    required this.headerBuilder,
    required this.subtitleBuilder,
    required this.primaryButtonBuilder,
    required this.secondaryButtonBuilder,
    required this.ratedHeaderBuilder,
    required this.ratedSubtitleBuilder,
    required this.ratedPrimaryButtonBuilder,
    required this.ratedSecondaryButtonBuilder,
    required this.additionalCommentBuilder,
    required this.ratingBuilder,
    required this.padding,
  });

  final Cqrs cqrs;
  final InAppReview inAppReview;
  final String appleStoreId;
  final String appVersion;
  final WidgetBuilder headerBuilder;
  final WidgetBuilder subtitleBuilder;
  final ButtonBuilder primaryButtonBuilder;
  final ButtonBuilder secondaryButtonBuilder;
  final RatedWidgetBuilder ratedHeaderBuilder;
  final RatedWidgetBuilder ratedSubtitleBuilder;
  final RatedButtonBuilder ratedPrimaryButtonBuilder;
  final RatedButtonBuilder ratedSecondaryButtonBuilder;
  final TextFieldBuilder additionalCommentBuilder;
  final RatingBuilder ratingBuilder;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
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
      child: Padding(
        padding: padding,
        child: BlocBuilder<RatingCubit, RatingState>(
          bloc: rateCubit,
          builder: (context, state) {
            if (state.rated) {
              return _Rated(
                rating: state.rating,
                rateCubit: rateCubit,
                headerBuilder: ratedHeaderBuilder,
                subtitleBuilder: ratedSubtitleBuilder,
                primaryButtonBuilder: ratedPrimaryButtonBuilder,
                secondaryButtonBuilder: ratedSecondaryButtonBuilder,
              );
            } else {
              return _NotRatedYet(
                headerBuilder: headerBuilder,
                subtitleBuilder: subtitleBuilder,
                ratingBuilder: ratingBuilder,
                rateCubit: rateCubit,
                additionalCommentBuilder: additionalCommentBuilder,
                textController: textController,
                primaryButtonBuilder: primaryButtonBuilder,
                secondaryButtonBuilder: secondaryButtonBuilder,
                expanded: state.expanded,
              );
            }
          },
        ),
      ),
    );
  }
}

class _NotRatedYet extends StatelessWidget {
  const _NotRatedYet({
    required this.headerBuilder,
    required this.subtitleBuilder,
    required this.ratingBuilder,
    required this.rateCubit,
    required this.additionalCommentBuilder,
    required this.textController,
    required this.primaryButtonBuilder,
    required this.secondaryButtonBuilder,
    required this.expanded,
  });

  final WidgetBuilder headerBuilder;
  final WidgetBuilder subtitleBuilder;
  final RatingBuilder ratingBuilder;
  final RatingCubit rateCubit;
  final TextFieldBuilder additionalCommentBuilder;
  final TextEditingController textController;
  final ButtonBuilder primaryButtonBuilder;
  final ButtonBuilder secondaryButtonBuilder;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        headerBuilder(context),
        const SizedBox(height: 8),
        subtitleBuilder(context),
        const SizedBox(height: 24),
        ratingBuilder(context, onChanged: rateCubit.setRating),
        const SizedBox(height: 24),
        if (expanded)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: additionalCommentBuilder(context, textController),
          ),
        primaryButtonBuilder(
          context,
          onPressed: () {
            rateCubit.submit(
              additionalComment: textController.text,
            );
          },
        ),
        const SizedBox(height: 8),
        secondaryButtonBuilder(
          context,
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}

class _Rated extends StatelessWidget {
  const _Rated({
    required this.rating,
    required this.rateCubit,
    required this.headerBuilder,
    required this.subtitleBuilder,
    required this.primaryButtonBuilder,
    required this.secondaryButtonBuilder,
  });

  final int rating;
  final RatingCubit rateCubit;
  final RatedWidgetBuilder headerBuilder;
  final RatedWidgetBuilder subtitleBuilder;
  final RatedButtonBuilder primaryButtonBuilder;
  final RatedButtonBuilder secondaryButtonBuilder;

  @override
  Widget build(BuildContext context) {
    final primaryButton = primaryButtonBuilder(
      context,
      rating,
      onPressed: rateCubit.openStore,
    );
    final secondaryButton = secondaryButtonBuilder(
      context,
      rating,
      onPressed: Navigator.of(context).pop,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        headerBuilder(context, rating),
        const SizedBox(height: 8),
        subtitleBuilder(context, rating),
        if (primaryButton != null) ...[
          const SizedBox(height: 24),
          primaryButton,
        ],
        if (secondaryButton != null) ...[
          SizedBox(height: primaryButton != null ? 8 : 24),
          secondaryButton,
        ],
      ],
    );
  }
}
