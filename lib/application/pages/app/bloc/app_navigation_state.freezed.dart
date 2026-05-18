// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_navigation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppNavigationState {
  AppScreen get screen => throw _privateConstructorUsedError;
  ChatContact get chatContact => throw _privateConstructorUsedError;

  /// Create a copy of AppNavigationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppNavigationStateCopyWith<AppNavigationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNavigationStateCopyWith<$Res> {
  factory $AppNavigationStateCopyWith(
    AppNavigationState value,
    $Res Function(AppNavigationState) then,
  ) = _$AppNavigationStateCopyWithImpl<$Res, AppNavigationState>;
  @useResult
  $Res call({AppScreen screen, ChatContact chatContact});

  $ChatContactCopyWith<$Res> get chatContact;
}

/// @nodoc
class _$AppNavigationStateCopyWithImpl<$Res, $Val extends AppNavigationState>
    implements $AppNavigationStateCopyWith<$Res> {
  _$AppNavigationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppNavigationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? screen = null, Object? chatContact = null}) {
    return _then(
      _value.copyWith(
            screen: null == screen
                ? _value.screen
                : screen // ignore: cast_nullable_to_non_nullable
                      as AppScreen,
            chatContact: null == chatContact
                ? _value.chatContact
                : chatContact // ignore: cast_nullable_to_non_nullable
                      as ChatContact,
          )
          as $Val,
    );
  }

  /// Create a copy of AppNavigationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatContactCopyWith<$Res> get chatContact {
    return $ChatContactCopyWith<$Res>(_value.chatContact, (value) {
      return _then(_value.copyWith(chatContact: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppNavigationStateImplCopyWith<$Res>
    implements $AppNavigationStateCopyWith<$Res> {
  factory _$$AppNavigationStateImplCopyWith(
    _$AppNavigationStateImpl value,
    $Res Function(_$AppNavigationStateImpl) then,
  ) = __$$AppNavigationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppScreen screen, ChatContact chatContact});

  @override
  $ChatContactCopyWith<$Res> get chatContact;
}

/// @nodoc
class __$$AppNavigationStateImplCopyWithImpl<$Res>
    extends _$AppNavigationStateCopyWithImpl<$Res, _$AppNavigationStateImpl>
    implements _$$AppNavigationStateImplCopyWith<$Res> {
  __$$AppNavigationStateImplCopyWithImpl(
    _$AppNavigationStateImpl _value,
    $Res Function(_$AppNavigationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppNavigationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? screen = null, Object? chatContact = null}) {
    return _then(
      _$AppNavigationStateImpl(
        screen: null == screen
            ? _value.screen
            : screen // ignore: cast_nullable_to_non_nullable
                  as AppScreen,
        chatContact: null == chatContact
            ? _value.chatContact
            : chatContact // ignore: cast_nullable_to_non_nullable
                  as ChatContact,
      ),
    );
  }
}

/// @nodoc

class _$AppNavigationStateImpl implements _AppNavigationState {
  const _$AppNavigationStateImpl({
    required this.screen,
    required this.chatContact,
  });

  @override
  final AppScreen screen;
  @override
  final ChatContact chatContact;

  @override
  String toString() {
    return 'AppNavigationState(screen: $screen, chatContact: $chatContact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppNavigationStateImpl &&
            (identical(other.screen, screen) || other.screen == screen) &&
            (identical(other.chatContact, chatContact) ||
                other.chatContact == chatContact));
  }

  @override
  int get hashCode => Object.hash(runtimeType, screen, chatContact);

  /// Create a copy of AppNavigationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppNavigationStateImplCopyWith<_$AppNavigationStateImpl> get copyWith =>
      __$$AppNavigationStateImplCopyWithImpl<_$AppNavigationStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AppNavigationState implements AppNavigationState {
  const factory _AppNavigationState({
    required final AppScreen screen,
    required final ChatContact chatContact,
  }) = _$AppNavigationStateImpl;

  @override
  AppScreen get screen;
  @override
  ChatContact get chatContact;

  /// Create a copy of AppNavigationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppNavigationStateImplCopyWith<_$AppNavigationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
