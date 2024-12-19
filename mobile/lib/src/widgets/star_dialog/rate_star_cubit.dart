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

  Future<void> submit({String? additionalComment}) async {
    emit(state.copyWith(inProgress: true));
    await cqrs.run(
      SubmitAppRating(
        rating: state.rating.toDouble(),
        metadata: {},
        platform: operatingSystem,
        systemVersion: systemVersion,
        appVersion: appVersion,
        additionalComment: additionalComment,
      ),
    );
    emit(state.copyWith(inProgress: false, rateUs: true));
  }
}

@freezed
abstract class RatingState with _$RatingState {
  const factory RatingState({
    @Default(0) int rating,
    @Default(false) bool inProgress,
    @Default(false) bool expanded,
    @Default(false) bool rateUs,
  }) = _RatingState;
}

sealed class RatingCubitEvent {}

class CloseDialogEvent implements RatingCubitEvent {
  const CloseDialogEvent();
}
