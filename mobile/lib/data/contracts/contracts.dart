// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
import 'package:leancode_contracts/leancode_contracts.dart';
part 'contracts.g.dart';

enum PlatformDTO {
  @JsonValue(0)
  android,
  @JsonValue(1)
  ios
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('RateApp')
@ContractsSerializable()
class RatingAlreadySent with EquatableMixin implements Query<bool> {
  RatingAlreadySent();

  factory RatingAlreadySent.fromJson(Map<String, dynamic> json) =>
      _$RatingAlreadySentFromJson(json);

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$RatingAlreadySentToJson(this);

  bool resultFactory(dynamic decodedJson) => decodedJson as bool;

  String getFullName() => 'LeanCode.AppRating.Contracts.RatingAlreadySent';
}

@ContractsSerializable()
class RatingPermissions with EquatableMixin {
  RatingPermissions();

  factory RatingPermissions.fromJson(Map<String, dynamic> json) =>
      _$RatingPermissionsFromJson(json);

  static const String rateApp = 'RateApp';

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$RatingPermissionsToJson(this);
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('RateApp')
@ContractsSerializable()
class SubmitAppRating with EquatableMixin implements Command {
  SubmitAppRating({
    required this.rating,
    required this.additionalComment,
    required this.platform,
    required this.systemVersion,
    required this.appVersion,
    required this.metadata,
  });

  factory SubmitAppRating.fromJson(Map<String, dynamic> json) =>
      _$SubmitAppRatingFromJson(json);

  final double rating;

  final String? additionalComment;

  final PlatformDTO platform;

  final String systemVersion;

  final String appVersion;

  final Map<String, Object>? metadata;

  List<Object?> get props => [
        rating,
        additionalComment,
        platform,
        systemVersion,
        appVersion,
        metadata
      ];

  Map<String, dynamic> toJson() => _$SubmitAppRatingToJson(this);

  String getFullName() => 'LeanCode.AppRating.Contracts.SubmitAppRating';
}

class SubmitAppRatingErrorCodes {
  static const ratingInvalid = 1;

  static const additionalCommentTooLong = 2;

  static const platformInvalid = 3;

  static const systemVersionRequired = 4;

  static const systemVersionTooLong = 5;

  static const appVersionRequired = 6;

  static const appVersionTooLong = 7;
}
