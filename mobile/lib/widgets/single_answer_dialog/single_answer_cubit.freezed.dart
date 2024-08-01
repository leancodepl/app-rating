// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'single_answer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnswerState {
  bool get inProgress => throw _privateConstructorUsedError;
  bool get expanded => throw _privateConstructorUsedError;
  bool get rateUs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnswerStateCopyWith<AnswerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerStateCopyWith<$Res> {
  factory $AnswerStateCopyWith(
          AnswerState value, $Res Function(AnswerState) then) =
      _$AnswerStateCopyWithImpl<$Res, AnswerState>;
  @useResult
  $Res call({bool inProgress, bool expanded, bool rateUs});
}

/// @nodoc
class _$AnswerStateCopyWithImpl<$Res, $Val extends AnswerState>
    implements $AnswerStateCopyWith<$Res> {
  _$AnswerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inProgress = null,
    Object? expanded = null,
    Object? rateUs = null,
  }) {
    return _then(_value.copyWith(
      inProgress: null == inProgress
          ? _value.inProgress
          : inProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
      rateUs: null == rateUs
          ? _value.rateUs
          : rateUs // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnswerStateImplCopyWith<$Res>
    implements $AnswerStateCopyWith<$Res> {
  factory _$$AnswerStateImplCopyWith(
          _$AnswerStateImpl value, $Res Function(_$AnswerStateImpl) then) =
      __$$AnswerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool inProgress, bool expanded, bool rateUs});
}

/// @nodoc
class __$$AnswerStateImplCopyWithImpl<$Res>
    extends _$AnswerStateCopyWithImpl<$Res, _$AnswerStateImpl>
    implements _$$AnswerStateImplCopyWith<$Res> {
  __$$AnswerStateImplCopyWithImpl(
      _$AnswerStateImpl _value, $Res Function(_$AnswerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inProgress = null,
    Object? expanded = null,
    Object? rateUs = null,
  }) {
    return _then(_$AnswerStateImpl(
      inProgress: null == inProgress
          ? _value.inProgress
          : inProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
      rateUs: null == rateUs
          ? _value.rateUs
          : rateUs // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AnswerStateImpl implements _AnswerState {
  const _$AnswerStateImpl(
      {this.inProgress = false, this.expanded = false, this.rateUs = false});

  @override
  @JsonKey()
  final bool inProgress;
  @override
  @JsonKey()
  final bool expanded;
  @override
  @JsonKey()
  final bool rateUs;

  @override
  String toString() {
    return 'AnswerState(inProgress: $inProgress, expanded: $expanded, rateUs: $rateUs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerStateImpl &&
            (identical(other.inProgress, inProgress) ||
                other.inProgress == inProgress) &&
            (identical(other.expanded, expanded) ||
                other.expanded == expanded) &&
            (identical(other.rateUs, rateUs) || other.rateUs == rateUs));
  }

  @override
  int get hashCode => Object.hash(runtimeType, inProgress, expanded, rateUs);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerStateImplCopyWith<_$AnswerStateImpl> get copyWith =>
      __$$AnswerStateImplCopyWithImpl<_$AnswerStateImpl>(this, _$identity);
}

abstract class _AnswerState implements AnswerState {
  const factory _AnswerState(
      {final bool inProgress,
      final bool expanded,
      final bool rateUs}) = _$AnswerStateImpl;

  @override
  bool get inProgress;
  @override
  bool get expanded;
  @override
  bool get rateUs;
  @override
  @JsonKey(ignore: true)
  _$$AnswerStateImplCopyWith<_$AnswerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
