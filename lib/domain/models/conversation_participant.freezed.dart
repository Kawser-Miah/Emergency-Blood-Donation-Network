// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_participant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ConversationParticipant {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get bloodGroup => throw _privateConstructorUsedError;
  String get initials => throw _privateConstructorUsedError;
  String get avatarColor => throw _privateConstructorUsedError;
  bool get online => throw _privateConstructorUsedError;
  DateTime? get lastSeen => throw _privateConstructorUsedError;

  /// Create a copy of ConversationParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationParticipantCopyWith<ConversationParticipant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationParticipantCopyWith<$Res> {
  factory $ConversationParticipantCopyWith(
    ConversationParticipant value,
    $Res Function(ConversationParticipant) then,
  ) = _$ConversationParticipantCopyWithImpl<$Res, ConversationParticipant>;
  @useResult
  $Res call({
    String uid,
    String name,
    String bloodGroup,
    String initials,
    String avatarColor,
    bool online,
    DateTime? lastSeen,
  });
}

/// @nodoc
class _$ConversationParticipantCopyWithImpl<
  $Res,
  $Val extends ConversationParticipant
>
    implements $ConversationParticipantCopyWith<$Res> {
  _$ConversationParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? bloodGroup = null,
    Object? initials = null,
    Object? avatarColor = null,
    Object? online = null,
    Object? lastSeen = freezed,
  }) {
    return _then(
      _value.copyWith(
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            bloodGroup: null == bloodGroup
                ? _value.bloodGroup
                : bloodGroup // ignore: cast_nullable_to_non_nullable
                      as String,
            initials: null == initials
                ? _value.initials
                : initials // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarColor: null == avatarColor
                ? _value.avatarColor
                : avatarColor // ignore: cast_nullable_to_non_nullable
                      as String,
            online: null == online
                ? _value.online
                : online // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastSeen: freezed == lastSeen
                ? _value.lastSeen
                : lastSeen // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConversationParticipantImplCopyWith<$Res>
    implements $ConversationParticipantCopyWith<$Res> {
  factory _$$ConversationParticipantImplCopyWith(
    _$ConversationParticipantImpl value,
    $Res Function(_$ConversationParticipantImpl) then,
  ) = __$$ConversationParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uid,
    String name,
    String bloodGroup,
    String initials,
    String avatarColor,
    bool online,
    DateTime? lastSeen,
  });
}

/// @nodoc
class __$$ConversationParticipantImplCopyWithImpl<$Res>
    extends
        _$ConversationParticipantCopyWithImpl<
          $Res,
          _$ConversationParticipantImpl
        >
    implements _$$ConversationParticipantImplCopyWith<$Res> {
  __$$ConversationParticipantImplCopyWithImpl(
    _$ConversationParticipantImpl _value,
    $Res Function(_$ConversationParticipantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? bloodGroup = null,
    Object? initials = null,
    Object? avatarColor = null,
    Object? online = null,
    Object? lastSeen = freezed,
  }) {
    return _then(
      _$ConversationParticipantImpl(
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        bloodGroup: null == bloodGroup
            ? _value.bloodGroup
            : bloodGroup // ignore: cast_nullable_to_non_nullable
                  as String,
        initials: null == initials
            ? _value.initials
            : initials // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarColor: null == avatarColor
            ? _value.avatarColor
            : avatarColor // ignore: cast_nullable_to_non_nullable
                  as String,
        online: null == online
            ? _value.online
            : online // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastSeen: freezed == lastSeen
            ? _value.lastSeen
            : lastSeen // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$ConversationParticipantImpl implements _ConversationParticipant {
  const _$ConversationParticipantImpl({
    required this.uid,
    required this.name,
    required this.bloodGroup,
    required this.initials,
    required this.avatarColor,
    this.online = false,
    this.lastSeen,
  });

  @override
  final String uid;
  @override
  final String name;
  @override
  final String bloodGroup;
  @override
  final String initials;
  @override
  final String avatarColor;
  @override
  @JsonKey()
  final bool online;
  @override
  final DateTime? lastSeen;

  @override
  String toString() {
    return 'ConversationParticipant(uid: $uid, name: $name, bloodGroup: $bloodGroup, initials: $initials, avatarColor: $avatarColor, online: $online, lastSeen: $lastSeen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationParticipantImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.initials, initials) ||
                other.initials == initials) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    uid,
    name,
    bloodGroup,
    initials,
    avatarColor,
    online,
    lastSeen,
  );

  /// Create a copy of ConversationParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationParticipantImplCopyWith<_$ConversationParticipantImpl>
  get copyWith =>
      __$$ConversationParticipantImplCopyWithImpl<
        _$ConversationParticipantImpl
      >(this, _$identity);
}

abstract class _ConversationParticipant implements ConversationParticipant {
  const factory _ConversationParticipant({
    required final String uid,
    required final String name,
    required final String bloodGroup,
    required final String initials,
    required final String avatarColor,
    final bool online,
    final DateTime? lastSeen,
  }) = _$ConversationParticipantImpl;

  @override
  String get uid;
  @override
  String get name;
  @override
  String get bloodGroup;
  @override
  String get initials;
  @override
  String get avatarColor;
  @override
  bool get online;
  @override
  DateTime? get lastSeen;

  /// Create a copy of ConversationParticipant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationParticipantImplCopyWith<_$ConversationParticipantImpl>
  get copyWith => throw _privateConstructorUsedError;
}
