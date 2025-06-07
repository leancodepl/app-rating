// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contracts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingAlreadySent _$RatingAlreadySentFromJson(Map<String, dynamic> json) =>
    RatingAlreadySent();

Map<String, dynamic> _$RatingAlreadySentToJson(RatingAlreadySent instance) =>
    <String, dynamic>{};

RatingPermissions _$RatingPermissionsFromJson(Map<String, dynamic> json) =>
    RatingPermissions();

Map<String, dynamic> _$RatingPermissionsToJson(RatingPermissions instance) =>
    <String, dynamic>{};

SubmitAppRating _$SubmitAppRatingFromJson(Map<String, dynamic> json) =>
    SubmitAppRating(
      rating: (json['Rating'] as num).toDouble(),
      additionalComment: json['AdditionalComment'] as String?,
      platform: $enumDecode(_$PlatformDTOEnumMap, json['Platform']),
      systemVersion: json['SystemVersion'] as String,
      appVersion: json['AppVersion'] as String,
      metadata: (json['Metadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Object),
      ),
    );

Map<String, dynamic> _$SubmitAppRatingToJson(SubmitAppRating instance) =>
    <String, dynamic>{
      'Rating': instance.rating,
      'AdditionalComment': instance.additionalComment,
      'Platform': _$PlatformDTOEnumMap[instance.platform],
      'SystemVersion': instance.systemVersion,
      'AppVersion': instance.appVersion,
      'Metadata': instance.metadata,
    };

const _$PlatformDTOEnumMap = {PlatformDTO.android: 0, PlatformDTO.ios: 1};
