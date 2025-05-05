import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:leancode_app_rating/src/data/contracts/contracts.dart';
import 'package:leancode_app_rating/src/utils/platform_info.dart';
import 'package:leancode_app_rating/src/widgets/single_answer_dialog/options_enum.dart';
import 'package:leancode_contracts/leancode_contracts.dart';

class SingleAnswerCubit extends Cubit<AnswerState>
    with BlocPresentationMixin<AnswerState, SingleAnswerCubitEvent> {
  SingleAnswerCubit({
    required this.inAppReview,
    required this.cqrs,
    required this.appVersion,
  }) : super(const AnswerState());

  final InAppReview inAppReview;
  final Cqrs cqrs;
  final String appVersion;

  Future<void> submitWithAdditionalInfo(String text) async {
    emit(state.copyWith(inProgress: true));
    await cqrs.run(
      SubmitAppRating(
        rating: 1,
        metadata: {},
        appVersion: appVersion,
        platform: operatingSystem,
        systemVersion: systemVersion,
        additionalComment: text,
      ),
    );
    emit(state.copyWith(inProgress: false));
    emitPresentation(const CloseDialogEvent());
  }

  Future<void> handleOptionSelection(RateOptions userChoice) async {
    switch (userChoice) {
      case RateOptions.yes:
        emit(state.copyWith(inProgress: true));
        await cqrs.run(
          SubmitAppRating(
            rating: 5,
            metadata: {},
            platform: operatingSystem,
            systemVersion: systemVersion,
            appVersion: appVersion,
            additionalComment: null,
          ),
        );
        emit(state.copyWith(inProgress: false));
        if (await inAppReview.isAvailable()) {
          await inAppReview.requestReview();
        }
        emitPresentation(const CloseDialogEvent());

      case RateOptions.no:
        emit(state.copyWith(expanded: true));

      case RateOptions.later:
        emitPresentation(const CloseDialogEvent());
    }
  }
}

class AnswerState with EquatableMixin {
  const AnswerState({
    this.inProgress = false,
    this.expanded = false,
    this.rateUs = false,
  });

  final bool inProgress;
  final bool expanded;
  final bool rateUs;

  AnswerState copyWith({
    bool? inProgress,
    bool? expanded,
    bool? rateUs,
  }) =>
      AnswerState(
        inProgress: inProgress ?? this.inProgress,
        expanded: expanded ?? this.expanded,
        rateUs: rateUs ?? this.rateUs,
      );

  @override
  List<Object?> get props => [inProgress, expanded, rateUs];
}

sealed class SingleAnswerCubitEvent {}

class CloseDialogEvent implements SingleAnswerCubitEvent {
  const CloseDialogEvent();
}
