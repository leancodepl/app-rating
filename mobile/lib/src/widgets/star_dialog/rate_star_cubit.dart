import 'package:leancode_app_rating/src/data/contracts/contracts.dart';
import 'package:leancode_app_rating/src/utils/platform_info.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:leancode_contracts/leancode_contracts.dart';

part 'rate_star_cubit.freezed.dart';

class RatingCubit extends Cubit<RatingState>
    with BlocPresentationMixin<RatingState, RatingCubitEvent> {
  RatingCubit({
    required this.cqrs,
    required this.inAppReview,
    required this.appStoreId,
    required this.appVersion,
  }) : super(const RatingState());

  final Cqrs cqrs;
  final InAppReview inAppReview;
  final String appStoreId;
  final String appVersion;

  void setRating(int rating) {
    final expanded = rating <= 4;
    emit(state.copyWith(rating: rating, expanded: expanded));
  }

  void openStore() {
    inAppReview.openStoreListing(
      appStoreId: appStoreId,
    );

    emitPresentation(const CloseDialogEvent());
  }

  void submit({String? additionalComment}) {
    emit(state.copyWith(rated: true));

    cqrs
        .run(
          SubmitAppRating(
            rating: state.rating.toDouble(),
            metadata: {},
            platform: operatingSystem,
            systemVersion: systemVersion,
            appVersion: appVersion,
            additionalComment: additionalComment,
          ),
        )
        .ignore();
  }
}

@freezed
abstract class RatingState with _$RatingState {
  const factory RatingState({
    @Default(0) int rating,
    @Default(false) bool expanded,
    @Default(false) bool rated,
  }) = _RatingState;
}

sealed class RatingCubitEvent {}

class CloseDialogEvent implements RatingCubitEvent {
  const CloseDialogEvent();
}
