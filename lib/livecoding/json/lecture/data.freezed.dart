// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TODO _$TODOFromJson(Map<String, dynamic> json) {
  return _TODO.fromJson(json);
}

/// @nodoc
mixin _$TODO {
  int get userId => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool? get completed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TODOCopyWith<TODO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TODOCopyWith<$Res> {
  factory $TODOCopyWith(TODO value, $Res Function(TODO) then) =
      _$TODOCopyWithImpl<$Res, TODO>;
  @useResult
  $Res call({int userId, int id, String title, bool? completed});
}

/// @nodoc
class _$TODOCopyWithImpl<$Res, $Val extends TODO>
    implements $TODOCopyWith<$Res> {
  _$TODOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = null,
    Object? title = null,
    Object? completed = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      completed: freezed == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TODOImplCopyWith<$Res> implements $TODOCopyWith<$Res> {
  factory _$$TODOImplCopyWith(
          _$TODOImpl value, $Res Function(_$TODOImpl) then) =
      __$$TODOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int userId, int id, String title, bool? completed});
}

/// @nodoc
class __$$TODOImplCopyWithImpl<$Res>
    extends _$TODOCopyWithImpl<$Res, _$TODOImpl>
    implements _$$TODOImplCopyWith<$Res> {
  __$$TODOImplCopyWithImpl(_$TODOImpl _value, $Res Function(_$TODOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = null,
    Object? title = null,
    Object? completed = freezed,
  }) {
    return _then(_$TODOImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      completed: freezed == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TODOImpl implements _TODO {
  const _$TODOImpl(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  factory _$TODOImpl.fromJson(Map<String, dynamic> json) =>
      _$$TODOImplFromJson(json);

  @override
  final int userId;
  @override
  final int id;
  @override
  final String title;
  @override
  final bool? completed;

  @override
  String toString() {
    return 'TODO(userId: $userId, id: $id, title: $title, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TODOImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, id, title, completed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TODOImplCopyWith<_$TODOImpl> get copyWith =>
      __$$TODOImplCopyWithImpl<_$TODOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TODOImplToJson(
      this,
    );
  }
}

abstract class _TODO implements TODO {
  const factory _TODO(
      {required final int userId,
      required final int id,
      required final String title,
      required final bool? completed}) = _$TODOImpl;

  factory _TODO.fromJson(Map<String, dynamic> json) = _$TODOImpl.fromJson;

  @override
  int get userId;
  @override
  int get id;
  @override
  String get title;
  @override
  bool? get completed;
  @override
  @JsonKey(ignore: true)
  _$$TODOImplCopyWith<_$TODOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
