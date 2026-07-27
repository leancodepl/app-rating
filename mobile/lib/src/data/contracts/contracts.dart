// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
import 'package:leancode_contracts/leancode_contracts.dart';
part 'contracts.g.dart';

enum PlatformDTO {
  @JsonValue(0)
  android,
  @JsonValue(1)
  ios,
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('RateApp')
@ContractsSerializable()
class RatingAlreadySent with Equatable implements Query<bool> {
  RatingAlreadySent();

  factory RatingAlreadySent.fromJson(Map<String, dynamic> json) =>
      _$RatingAlreadySentFromJson(json);

  static const fullName$ = 'LeanCode.AppRating.Contracts.RatingAlreadySent';

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$RatingAlreadySentToJson(this);

  bool resultFactory(dynamic decodedJson) => decodedJson as bool;

  String getFullName() => fullName$;
}

@ContractsSerializable()
class RatingPermissions with Equatable {
  RatingPermissions();

  factory RatingPermissions.fromJson(Map<String, dynamic> json) =>
      _$RatingPermissionsFromJson(json);

  static const String rateApp = 'RateApp';

  static const fullName$ = 'LeanCode.AppRating.Contracts.RatingPermissions';

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$RatingPermissionsToJson(this);
}

/// LeanCode.Contracts.Security.AllowUnauthorizedAttribute()
@ContractsSerializable()
class SubmitAppRating with Equatable implements Command {
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

  static const fullName$ = 'LeanCode.AppRating.Contracts.SubmitAppRating';

  List<Object?> get props => [
    rating,
    additionalComment,
    platform,
    systemVersion,
    appVersion,
    metadata,
  ];

  Map<String, dynamic> toJson() => _$SubmitAppRatingToJson(this);

  String getFullName() => fullName$;
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
