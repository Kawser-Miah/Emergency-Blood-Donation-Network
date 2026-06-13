// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatSource {
  ChatSourceType get type => throw _privateConstructorUsedError;
  String? get referenceId => throw _privateConstructorUsedError;

  /// Create a copy of ChatSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatSourceCopyWith<ChatSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatSourceCopyWith<$Res> {
  factory $ChatSourceCopyWith(
    ChatSource value,
    $Res Function(ChatSource) then,
  ) = _$ChatSourceCopyWithImpl<$Res, ChatSource>;
  @useResult
  $Res call({ChatSourceType type, String? referenceId});
}

/// @nodoc
class _$ChatSourceCopyWithImpl<$Res, $Val extends ChatSource>
    implements $ChatSourceCopyWith<$Res> {
  _$ChatSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? referenceId = freezed}) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ChatSourceType,
            referenceId: freezed == referenceId
                ? _value.referenceId
                : referenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatSourceImplCopyWith<$Res>
    implements $ChatSourceCopyWith<$Res> {
  factory _$$ChatSourceImplCopyWith(
    _$ChatSourceImpl value,
    $Res Function(_$ChatSourceImpl) then,
  ) = __$$ChatSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChatSourceType type, String? referenceId});
}

/// @nodoc
class __$$ChatSourceImplCopyWithImpl<$Res>
    extends _$ChatSourceCopyWithImpl<$Res, _$ChatSourceImpl>
    implements _$$ChatSourceImplCopyWith<$Res> {
  __$$ChatSourceImplCopyWithImpl(
    _$ChatSourceImpl _value,
    $Res Function(_$ChatSourceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? referenceId = freezed}) {
    return _then(
      _$ChatSourceImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ChatSourceType,
        referenceId: freezed == referenceId
            ? _value.referenceId
            : referenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ChatSourceImpl implements _ChatSource {
  const _$ChatSourceImpl({required this.type, this.referenceId});

  @override
  final ChatSourceType type;
  @override
  final String? referenceId;

  @override
  String toString() {
    return 'ChatSource(type: $type, referenceId: $referenceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatSourceImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, referenceId);

  /// Create a copy of ChatSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatSourceImplCopyWith<_$ChatSourceImpl> get copyWith =>
      __$$ChatSourceImplCopyWithImpl<_$ChatSourceImpl>(this, _$identity);
}

abstract class _ChatSource implements ChatSource {
  const factory _ChatSource({
    required final ChatSourceType type,
    final String? referenceId,
  }) = _$ChatSourceImpl;

  @override
  ChatSourceType get type;
  @override
  String? get referenceId;

  /// Create a copy of ChatSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatSourceImplCopyWith<_$ChatSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
