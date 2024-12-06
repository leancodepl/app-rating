import 'package:leancode_app_rating/data/contracts/contracts.dart';
import 'package:leancode_app_rating/utils/platform_info.dart';
import 'package:leancode_app_rating/widgets/single_answer_dialog/options_enum.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:leancode_contracts/leancode_contracts.dart';

part 'single_answer_cubit.freezed.dart';

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
          inAppReview.requestReview();
        }
        emitPresentation(const CloseDialogEvent());
        break;

      case RateOptions.no:
        emit(state.copyWith(expanded: true));

      case RateOptions.later:
        emitPresentation(const CloseDialogEvent());
    }
  }
}

@freezed
abstract class AnswerState with _$AnswerState {
  const factory AnswerState({
    @Default(false) bool inProgress,
    @Default(false) bool expanded,
    @Default(false) bool rateUs,
  }) = _AnswerState;
}

sealed class SingleAnswerCubitEvent {}

class CloseDialogEvent implements SingleAnswerCubitEvent {
  const CloseDialogEvent();
}
