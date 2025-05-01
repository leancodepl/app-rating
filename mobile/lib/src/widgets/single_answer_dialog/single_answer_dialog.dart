import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:leancode_app_rating/src/utils/strings.dart';
import 'package:leancode_app_rating/src/widgets/buttons/primary_button.dart';
import 'package:leancode_app_rating/src/widgets/buttons/secondary_button.dart';
import 'package:leancode_app_rating/src/widgets/common/base_dialog.dart';
import 'package:leancode_app_rating/src/widgets/common/feedback_text_field.dart';
import 'package:leancode_app_rating/src/widgets/common/loading_overlay.dart';
import 'package:leancode_app_rating/src/widgets/common/text_styles.dart';
import 'package:leancode_app_rating/src/widgets/single_answer_dialog/options_enum.dart';
import 'package:leancode_app_rating/src/widgets/single_answer_dialog/single_answer_cubit.dart';
import 'package:leancode_contracts/leancode_contracts.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class SingleAnswerDialog extends HookWidget {
  const SingleAnswerDialog({
    super.key,
    required this.inAppReview,
    required this.cqrs,
    required this.appVersion,
    this.singleAnswerDialogHeader,
    this.singleAnswerDialogPositiveButton,
    this.singleAnswerDialogNegativeButton,
    this.singleAnswerDialogCancelButton,
    this.singleAnswerDialogMoreInfoHeader,
    this.singleAnswerDialogMoreInfoPrimaryButton,
    this.singleAnswerDialogMoreInfoSecondaryButton,
  });

  final Cqrs cqrs;
  final InAppReview inAppReview;
  final String appVersion;
  final String? singleAnswerDialogHeader;
  final String? singleAnswerDialogPositiveButton;
  final String? singleAnswerDialogNegativeButton;
  final String? singleAnswerDialogCancelButton;
  final String? singleAnswerDialogMoreInfoHeader;
  final String? singleAnswerDialogMoreInfoPrimaryButton;
  final String? singleAnswerDialogMoreInfoSecondaryButton;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    final answerCubit = useBloc(
      () => SingleAnswerCubit(
        inAppReview: inAppReview,
        cqrs: cqrs,
        appVersion: appVersion,
      ),
    );
    final textFieldController = useTextEditingController();

    useOnStreamChange(
      answerCubit.presentation,
      onData: (event) {
        if (event is CloseDialogEvent) {
          Navigator.of(context).pop();
        }
      },
    );

    return BaseDialog(
      child: BlocBuilder<SingleAnswerCubit, AnswerState>(
        bloc: answerCubit,
        builder: (context, state) {
          if (state.expanded) {
            return NotSatisfiedStep(
              textFieldController: textFieldController,
              answerCubit: answerCubit,
              singleAnswerDialogMoreInfoHeader:
                  singleAnswerDialogMoreInfoHeader,
              singleAnswerDialogMoreInfoPrimaryButton:
                  singleAnswerDialogMoreInfoPrimaryButton,
              singleAnswerDialogMoreInfoSecondaryButton:
                  singleAnswerDialogMoreInfoSecondaryButton,
            );
          }
          return AppLoadingOverlay(
            isLoading: state.inProgress,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    singleAnswerDialogHeader ?? s.singleAnswerDialogHeader,
                    style: headerStyle,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  PrimaryButton(
                    label: singleAnswerDialogPositiveButton ??
                        s.singleAnswerDialogPositiveButton,
                    onPressed: () =>
                        answerCubit.handleOptionSelection(RateOptions.yes),
                  ),
                  const SizedBox(height: 8),
                  SecondaryButton(
                    label: singleAnswerDialogNegativeButton ??
                        s.singleAnswerDialogNegativeButton,
                    onPressed: () =>
                        answerCubit.handleOptionSelection(RateOptions.no),
                  ),
                  const SizedBox(height: 8),
                  SecondaryButton(
                    label: singleAnswerDialogCancelButton ??
                        s.singleAnswerDialogCancelButton,
                    onPressed: () =>
                        answerCubit.handleOptionSelection(RateOptions.later),
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

class NotSatisfiedStep extends StatelessWidget {
  const NotSatisfiedStep({
    super.key,
    required this.textFieldController,
    required this.answerCubit,
    this.singleAnswerDialogMoreInfoHeader,
    this.singleAnswerDialogMoreInfoPrimaryButton,
    this.singleAnswerDialogMoreInfoSecondaryButton,
  });

  final TextEditingController textFieldController;
  final SingleAnswerCubit answerCubit;
  final String? singleAnswerDialogMoreInfoHeader;
  final String? singleAnswerDialogMoreInfoPrimaryButton;
  final String? singleAnswerDialogMoreInfoSecondaryButton;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            singleAnswerDialogMoreInfoHeader ??
                s.singleAnswerDialogMoreInfoHeader,
            style: headerStyle,
          ),
          const SizedBox(
            height: 24,
          ),
          FeedbackTextField(
            textController: textFieldController,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: singleAnswerDialogMoreInfoPrimaryButton ??
                s.singleAnswerDialogMoreInfoPrimaryButton,
            onPressed: () {
              answerCubit.submitWithAdditionalInfo(textFieldController.text);
            },
          ),
          const SizedBox(height: 8),
          SecondaryButton(
            label: singleAnswerDialogMoreInfoSecondaryButton ??
                s.singleAnswerDialogMoreInfoSecondaryButton,
            onPressed: Navigator.of(context).pop,
          ),
        ],
      ),
    );
  }
}
