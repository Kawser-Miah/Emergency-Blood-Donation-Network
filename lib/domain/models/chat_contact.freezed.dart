// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatContact {
  String get name => throw _privateConstructorUsedError;
  String get bloodGroup => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get initials => throw _privateConstructorUsedError;
  String get avatarColor => throw _privateConstructorUsedError;
  bool get online => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;

  /// Create a copy of ChatContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatContactCopyWith<ChatContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatContactCopyWith<$Res> {
  factory $ChatContactCopyWith(
    ChatContact value,
    $Res Function(ChatContact) then,
  ) = _$ChatContactCopyWithImpl<$Res, ChatContact>;
  @useResult
  $Res call({
    String name,
    String bloodGroup,
    String id,
    String initials,
    String avatarColor,
    bool online,
    String? photoUrl,
  });
}

/// @nodoc
class _$ChatContactCopyWithImpl<$Res, $Val extends ChatContact>
    implements $ChatContactCopyWith<$Res> {
  _$ChatContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? bloodGroup = null,
    Object? id = null,
    Object? initials = null,
    Object? avatarColor = null,
    Object? online = null,
    Object? photoUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            bloodGroup: null == bloodGroup
                ? _value.bloodGroup
                : bloodGroup // ignore: cast_nullable_to_non_nullable
                      as String,
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
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
            photoUrl: freezed == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatContactImplCopyWith<$Res>
    implements $ChatContactCopyWith<$Res> {
  factory _$$ChatContactImplCopyWith(
    _$ChatContactImpl value,
    $Res Function(_$ChatContactImpl) then,
  ) = __$$ChatContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String bloodGroup,
    String id,
    String initials,
    String avatarColor,
    bool online,
    String? photoUrl,
  });
}

/// @nodoc
class __$$ChatContactImplCopyWithImpl<$Res>
    extends _$ChatContactCopyWithImpl<$Res, _$ChatContactImpl>
    implements _$$ChatContactImplCopyWith<$Res> {
  __$$ChatContactImplCopyWithImpl(
    _$ChatContactImpl _value,
    $Res Function(_$ChatContactImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? bloodGroup = null,
    Object? id = null,
    Object? initials = null,
    Object? avatarColor = null,
    Object? online = null,
    Object? photoUrl = freezed,
  }) {
    return _then(
      _$ChatContactImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        bloodGroup: null == bloodGroup
            ? _value.bloodGroup
            : bloodGroup // ignore: cast_nullable_to_non_nullable
                  as String,
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
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
        photoUrl: freezed == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ChatContactImpl implements _ChatContact {
  const _$ChatContactImpl({
    required this.name,
    required this.bloodGroup,
    required this.id,
    required this.initials,
    required this.avatarColor,
    required this.online,
    this.photoUrl,
  });

  @override
  final String name;
  @override
  final String bloodGroup;
  @override
  final String id;
  @override
  final String initials;
  @override
  final String avatarColor;
  @override
  final bool online;
  @override
  final String? photoUrl;

  @override
  String toString() {
    return 'ChatContact(name: $name, bloodGroup: $bloodGroup, id: $id, initials: $initials, avatarColor: $avatarColor, online: $online, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatContactImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.initials, initials) ||
                other.initials == initials) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    bloodGroup,
    id,
    initials,
    avatarColor,
    online,
    photoUrl,
  );

  /// Create a copy of ChatContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatContactImplCopyWith<_$ChatContactImpl> get copyWith =>
      __$$ChatContactImplCopyWithImpl<_$ChatContactImpl>(this, _$identity);
}

abstract class _ChatContact implements ChatContact {
  const factory _ChatContact({
    required final String name,
    required final String bloodGroup,
    required final String id,
    required final String initials,
    required final String avatarColor,
    required final bool online,
    final String? photoUrl,
  }) = _$ChatContactImpl;

  @override
  String get name;
  @override
  String get bloodGroup;
  @override
  String get id;
  @override
  String get initials;
  @override
  String get avatarColor;
  @override
  bool get online;
  @override
  String? get photoUrl;

  /// Create a copy of ChatContact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatContactImplCopyWith<_$ChatContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
