// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cat_status_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CatStatusCode _$CatStatusCodeFromJson(Map<String, dynamic> json) {
  return _CatStatusCode.fromJson(json);
}

/// @nodoc
mixin _$CatStatusCode {
  int get statusCode => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CatStatusCodeCopyWith<CatStatusCode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatStatusCodeCopyWith<$Res> {
  factory $CatStatusCodeCopyWith(
          CatStatusCode value, $Res Function(CatStatusCode) then) =
      _$CatStatusCodeCopyWithImpl<$Res, CatStatusCode>;
  @useResult
  $Res call({int statusCode, String message});
}

/// @nodoc
class _$CatStatusCodeCopyWithImpl<$Res, $Val extends CatStatusCode>
    implements $CatStatusCodeCopyWith<$Res> {
  _$CatStatusCodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CatStatusCodeImplCopyWith<$Res>
    implements $CatStatusCodeCopyWith<$Res> {
  factory _$$CatStatusCodeImplCopyWith(
          _$CatStatusCodeImpl value, $Res Function(_$CatStatusCodeImpl) then) =
      __$$CatStatusCodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int statusCode, String message});
}

/// @nodoc
class __$$CatStatusCodeImplCopyWithImpl<$Res>
    extends _$CatStatusCodeCopyWithImpl<$Res, _$CatStatusCodeImpl>
    implements _$$CatStatusCodeImplCopyWith<$Res> {
  __$$CatStatusCodeImplCopyWithImpl(
      _$CatStatusCodeImpl _value, $Res Function(_$CatStatusCodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_$CatStatusCodeImpl(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CatStatusCodeImpl implements _CatStatusCode {
  const _$CatStatusCodeImpl({required this.statusCode, required this.message});

  factory _$CatStatusCodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatStatusCodeImplFromJson(json);

  @override
  final int statusCode;
  @override
  final String message;

  @override
  String toString() {
    return 'CatStatusCode(statusCode: $statusCode, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatStatusCodeImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CatStatusCodeImplCopyWith<_$CatStatusCodeImpl> get copyWith =>
      __$$CatStatusCodeImplCopyWithImpl<_$CatStatusCodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CatStatusCodeImplToJson(
      this,
    );
  }
}

abstract class _CatStatusCode implements CatStatusCode {
  const factory _CatStatusCode(
      {required final int statusCode,
      required final String message}) = _$CatStatusCodeImpl;

  factory _CatStatusCode.fromJson(Map<String, dynamic> json) =
      _$CatStatusCodeImpl.fromJson;

  @override
  int get statusCode;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$CatStatusCodeImplCopyWith<_$CatStatusCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
