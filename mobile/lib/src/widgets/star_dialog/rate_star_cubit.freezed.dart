// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rate_star_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RatingState {
  int get rating => throw _privateConstructorUsedError;
  bool get expanded => throw _privateConstructorUsedError;
  bool get rated => throw _privateConstructorUsedError;

  /// Create a copy of RatingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingStateCopyWith<RatingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingStateCopyWith<$Res> {
  factory $RatingStateCopyWith(
          RatingState value, $Res Function(RatingState) then) =
      _$RatingStateCopyWithImpl<$Res, RatingState>;
  @useResult
  $Res call({int rating, bool expanded, bool rated});
}

/// @nodoc
class _$RatingStateCopyWithImpl<$Res, $Val extends RatingState>
    implements $RatingStateCopyWith<$Res> {
  _$RatingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
    Object? expanded = null,
    Object? rated = null,
  }) {
    return _then(_value.copyWith(
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
      rated: null == rated
          ? _value.rated
          : rated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RatingStateImplCopyWith<$Res>
    implements $RatingStateCopyWith<$Res> {
  factory _$$RatingStateImplCopyWith(
          _$RatingStateImpl value, $Res Function(_$RatingStateImpl) then) =
      __$$RatingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int rating, bool expanded, bool rated});
}

/// @nodoc
class __$$RatingStateImplCopyWithImpl<$Res>
    extends _$RatingStateCopyWithImpl<$Res, _$RatingStateImpl>
    implements _$$RatingStateImplCopyWith<$Res> {
  __$$RatingStateImplCopyWithImpl(
      _$RatingStateImpl _value, $Res Function(_$RatingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RatingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
    Object? expanded = null,
    Object? rated = null,
  }) {
    return _then(_$RatingStateImpl(
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
      rated: null == rated
          ? _value.rated
          : rated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RatingStateImpl implements _RatingState {
  const _$RatingStateImpl(
      {this.rating = 0, this.expanded = false, this.rated = false});

  @override
  @JsonKey()
  final int rating;
  @override
  @JsonKey()
  final bool expanded;
  @override
  @JsonKey()
  final bool rated;

  @override
  String toString() {
    return 'RatingState(rating: $rating, expanded: $expanded, rated: $rated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingStateImpl &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.expanded, expanded) ||
                other.expanded == expanded) &&
            (identical(other.rated, rated) || other.rated == rated));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rating, expanded, rated);

  /// Create a copy of RatingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingStateImplCopyWith<_$RatingStateImpl> get copyWith =>
      __$$RatingStateImplCopyWithImpl<_$RatingStateImpl>(this, _$identity);
}

abstract class _RatingState implements RatingState {
  const factory _RatingState(
      {final int rating,
      final bool expanded,
      final bool rated}) = _$RatingStateImpl;

  @override
  int get rating;
  @override
  bool get expanded;
  @override
  bool get rated;

  /// Create a copy of RatingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingStateImplCopyWith<_$RatingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
