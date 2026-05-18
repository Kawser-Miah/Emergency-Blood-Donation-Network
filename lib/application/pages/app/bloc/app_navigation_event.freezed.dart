// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_navigation_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppNavigationEvent {
  AppScreen get screen => throw _privateConstructorUsedError;
  ChatContact? get contact => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AppScreen screen, ChatContact? contact) navigated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppScreen screen, ChatContact? contact)? navigated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppScreen screen, ChatContact? contact)? navigated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Navigated value) navigated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Navigated value)? navigated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Navigated value)? navigated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of AppNavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppNavigationEventCopyWith<AppNavigationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNavigationEventCopyWith<$Res> {
  factory $AppNavigationEventCopyWith(
    AppNavigationEvent value,
    $Res Function(AppNavigationEvent) then,
  ) = _$AppNavigationEventCopyWithImpl<$Res, AppNavigationEvent>;
  @useResult
  $Res call({AppScreen screen, ChatContact? contact});

  $ChatContactCopyWith<$Res>? get contact;
}

/// @nodoc
class _$AppNavigationEventCopyWithImpl<$Res, $Val extends AppNavigationEvent>
    implements $AppNavigationEventCopyWith<$Res> {
  _$AppNavigationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppNavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? screen = null, Object? contact = freezed}) {
    return _then(
      _value.copyWith(
            screen: null == screen
                ? _value.screen
                : screen // ignore: cast_nullable_to_non_nullable
                      as AppScreen,
            contact: freezed == contact
                ? _value.contact
                : contact // ignore: cast_nullable_to_non_nullable
                      as ChatContact?,
          )
          as $Val,
    );
  }

  /// Create a copy of AppNavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatContactCopyWith<$Res>? get contact {
    if (_value.contact == null) {
      return null;
    }

    return $ChatContactCopyWith<$Res>(_value.contact!, (value) {
      return _then(_value.copyWith(contact: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NavigatedImplCopyWith<$Res>
    implements $AppNavigationEventCopyWith<$Res> {
  factory _$$NavigatedImplCopyWith(
    _$NavigatedImpl value,
    $Res Function(_$NavigatedImpl) then,
  ) = __$$NavigatedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppScreen screen, ChatContact? contact});

  @override
  $ChatContactCopyWith<$Res>? get contact;
}

/// @nodoc
class __$$NavigatedImplCopyWithImpl<$Res>
    extends _$AppNavigationEventCopyWithImpl<$Res, _$NavigatedImpl>
    implements _$$NavigatedImplCopyWith<$Res> {
  __$$NavigatedImplCopyWithImpl(
    _$NavigatedImpl _value,
    $Res Function(_$NavigatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppNavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? screen = null, Object? contact = freezed}) {
    return _then(
      _$NavigatedImpl(
        null == screen
            ? _value.screen
            : screen // ignore: cast_nullable_to_non_nullable
                  as AppScreen,
        contact: freezed == contact
            ? _value.contact
            : contact // ignore: cast_nullable_to_non_nullable
                  as ChatContact?,
      ),
    );
  }
}

/// @nodoc

class _$NavigatedImpl implements _Navigated {
  const _$NavigatedImpl(this.screen, {this.contact});

  @override
  final AppScreen screen;
  @override
  final ChatContact? contact;

  @override
  String toString() {
    return 'AppNavigationEvent.navigated(screen: $screen, contact: $contact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigatedImpl &&
            (identical(other.screen, screen) || other.screen == screen) &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @override
  int get hashCode => Object.hash(runtimeType, screen, contact);

  /// Create a copy of AppNavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NavigatedImplCopyWith<_$NavigatedImpl> get copyWith =>
      __$$NavigatedImplCopyWithImpl<_$NavigatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AppScreen screen, ChatContact? contact) navigated,
  }) {
    return navigated(screen, contact);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppScreen screen, ChatContact? contact)? navigated,
  }) {
    return navigated?.call(screen, contact);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppScreen screen, ChatContact? contact)? navigated,
    required TResult orElse(),
  }) {
    if (navigated != null) {
      return navigated(screen, contact);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Navigated value) navigated,
  }) {
    return navigated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Navigated value)? navigated,
  }) {
    return navigated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Navigated value)? navigated,
    required TResult orElse(),
  }) {
    if (navigated != null) {
      return navigated(this);
    }
    return orElse();
  }
}

abstract class _Navigated implements AppNavigationEvent {
  const factory _Navigated(
    final AppScreen screen, {
    final ChatContact? contact,
  }) = _$NavigatedImpl;

  @override
  AppScreen get screen;
  @override
  ChatContact? get contact;

  /// Create a copy of AppNavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NavigatedImplCopyWith<_$NavigatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
