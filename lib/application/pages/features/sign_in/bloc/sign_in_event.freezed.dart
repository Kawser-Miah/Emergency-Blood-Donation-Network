// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SignInEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() googleSignInPressed,
    required TResult Function() signOut,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? googleSignInPressed,
    TResult? Function()? signOut,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? googleSignInPressed,
    TResult Function()? signOut,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoogleSignInPressed value) googleSignInPressed,
    required TResult Function(_GoogleSignoutEvent value) signOut,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoogleSignInPressed value)? googleSignInPressed,
    TResult? Function(_GoogleSignoutEvent value)? signOut,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoogleSignInPressed value)? googleSignInPressed,
    TResult Function(_GoogleSignoutEvent value)? signOut,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInEventCopyWith<$Res> {
  factory $SignInEventCopyWith(
    SignInEvent value,
    $Res Function(SignInEvent) then,
  ) = _$SignInEventCopyWithImpl<$Res, SignInEvent>;
}

/// @nodoc
class _$SignInEventCopyWithImpl<$Res, $Val extends SignInEvent>
    implements $SignInEventCopyWith<$Res> {
  _$SignInEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GoogleSignInPressedImplCopyWith<$Res> {
  factory _$$GoogleSignInPressedImplCopyWith(
    _$GoogleSignInPressedImpl value,
    $Res Function(_$GoogleSignInPressedImpl) then,
  ) = __$$GoogleSignInPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GoogleSignInPressedImplCopyWithImpl<$Res>
    extends _$SignInEventCopyWithImpl<$Res, _$GoogleSignInPressedImpl>
    implements _$$GoogleSignInPressedImplCopyWith<$Res> {
  __$$GoogleSignInPressedImplCopyWithImpl(
    _$GoogleSignInPressedImpl _value,
    $Res Function(_$GoogleSignInPressedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GoogleSignInPressedImpl implements _GoogleSignInPressed {
  const _$GoogleSignInPressedImpl();

  @override
  String toString() {
    return 'SignInEvent.googleSignInPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoogleSignInPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() googleSignInPressed,
    required TResult Function() signOut,
  }) {
    return googleSignInPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? googleSignInPressed,
    TResult? Function()? signOut,
  }) {
    return googleSignInPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? googleSignInPressed,
    TResult Function()? signOut,
    required TResult orElse(),
  }) {
    if (googleSignInPressed != null) {
      return googleSignInPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoogleSignInPressed value) googleSignInPressed,
    required TResult Function(_GoogleSignoutEvent value) signOut,
  }) {
    return googleSignInPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoogleSignInPressed value)? googleSignInPressed,
    TResult? Function(_GoogleSignoutEvent value)? signOut,
  }) {
    return googleSignInPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoogleSignInPressed value)? googleSignInPressed,
    TResult Function(_GoogleSignoutEvent value)? signOut,
    required TResult orElse(),
  }) {
    if (googleSignInPressed != null) {
      return googleSignInPressed(this);
    }
    return orElse();
  }
}

abstract class _GoogleSignInPressed implements SignInEvent {
  const factory _GoogleSignInPressed() = _$GoogleSignInPressedImpl;
}

/// @nodoc
abstract class _$$GoogleSignoutEventImplCopyWith<$Res> {
  factory _$$GoogleSignoutEventImplCopyWith(
    _$GoogleSignoutEventImpl value,
    $Res Function(_$GoogleSignoutEventImpl) then,
  ) = __$$GoogleSignoutEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GoogleSignoutEventImplCopyWithImpl<$Res>
    extends _$SignInEventCopyWithImpl<$Res, _$GoogleSignoutEventImpl>
    implements _$$GoogleSignoutEventImplCopyWith<$Res> {
  __$$GoogleSignoutEventImplCopyWithImpl(
    _$GoogleSignoutEventImpl _value,
    $Res Function(_$GoogleSignoutEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignInEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GoogleSignoutEventImpl implements _GoogleSignoutEvent {
  const _$GoogleSignoutEventImpl();

  @override
  String toString() {
    return 'SignInEvent.signOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GoogleSignoutEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() googleSignInPressed,
    required TResult Function() signOut,
  }) {
    return signOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? googleSignInPressed,
    TResult? Function()? signOut,
  }) {
    return signOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? googleSignInPressed,
    TResult Function()? signOut,
    required TResult orElse(),
  }) {
    if (signOut != null) {
      return signOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GoogleSignInPressed value) googleSignInPressed,
    required TResult Function(_GoogleSignoutEvent value) signOut,
  }) {
    return signOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GoogleSignInPressed value)? googleSignInPressed,
    TResult? Function(_GoogleSignoutEvent value)? signOut,
  }) {
    return signOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GoogleSignInPressed value)? googleSignInPressed,
    TResult Function(_GoogleSignoutEvent value)? signOut,
    required TResult orElse(),
  }) {
    if (signOut != null) {
      return signOut(this);
    }
    return orElse();
  }
}

abstract class _GoogleSignoutEvent implements SignInEvent {
  const factory _GoogleSignoutEvent() = _$GoogleSignoutEventImpl;
}
