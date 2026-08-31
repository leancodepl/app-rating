import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:leancode_app_rating/src/widgets/common/base_dialog.dart';
import 'package:leancode_app_rating/src/widgets/star_dialog/rate_star_cubit.dart';
import 'package:leancode_contracts/leancode_contracts.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

typedef ButtonBuilder =
    Widget Function(
      BuildContext context,
      int rating, {
      required VoidCallback onPressed,
    });

typedef TextFieldBuilder =
    Widget Function(
      BuildContext context,
      int rating,
      TextEditingController textController,
    );

typedef RatingBuilder =
    Widget Function(
      BuildContext context,
      int rating, {
      required ValueChanged<int> onChanged,
    });

typedef RatedWidgetBuilder = Widget Function(BuildContext context, int rating);

typedef RatedButtonBuilder =
    Widget? Function(
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
    this.backgroundColor,
  });

  final Cqrs cqrs;
  final InAppReview inAppReview;
  final String appleStoreId;
  final String appVersion;
  final RatedWidgetBuilder headerBuilder;
  final RatedWidgetBuilder subtitleBuilder;
  final ButtonBuilder primaryButtonBuilder;
  final ButtonBuilder secondaryButtonBuilder;
  final RatedWidgetBuilder ratedHeaderBuilder;
  final RatedWidgetBuilder ratedSubtitleBuilder;
  final RatedButtonBuilder ratedPrimaryButtonBuilder;
  final RatedButtonBuilder ratedSecondaryButtonBuilder;
  final TextFieldBuilder additionalCommentBuilder;
  final RatingBuilder ratingBuilder;
  final EdgeInsets padding;

  /// The dialog's background color. Defaults to
  /// [DialogThemeData.backgroundColor].
  final Color? backgroundColor;

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

    useOnStreamChange(
      rateCubit.presentation,
      onData: (event) {
        switch (event) {
          case CloseDialogEvent():
            Navigator.of(context).pop();
        }
      },
    );

    final textController = useTextEditingController();

    return BaseDialog(
      backgroundColor: backgroundColor,
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
                rating: state.rating,
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
    required this.rating,
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

  final int rating;
  final RatedWidgetBuilder headerBuilder;
  final RatedWidgetBuilder subtitleBuilder;
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
        headerBuilder(context, rating),
        const SizedBox(height: 8),
        subtitleBuilder(context, rating),
        const SizedBox(height: 24),
        ratingBuilder(context, rating, onChanged: rateCubit.setRating),
        const SizedBox(height: 24),
        if (expanded)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: additionalCommentBuilder(context, rating, textController),
          ),
        primaryButtonBuilder(
          context,
          rating,
          onPressed: () {
            rateCubit.submit(additionalComment: textController.text);
          },
        ),
        const SizedBox(height: 8),
        secondaryButtonBuilder(
          context,
          rating,
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
