// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProfileEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() infoExpandedToggled,
    required TResult Function() notificationsToggled,
    required TResult Function() darkModeToggled,
    required TResult Function() quietHoursToggled,
    required TResult Function(String hospital, String bloodGroup, DateTime date)
    donationSubmitted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? infoExpandedToggled,
    TResult? Function()? notificationsToggled,
    TResult? Function()? darkModeToggled,
    TResult? Function()? quietHoursToggled,
    TResult? Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? infoExpandedToggled,
    TResult Function()? notificationsToggled,
    TResult Function()? darkModeToggled,
    TResult Function()? quietHoursToggled,
    TResult Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_InfoExpandedToggled value) infoExpandedToggled,
    required TResult Function(_NotificationsToggled value) notificationsToggled,
    required TResult Function(_DarkModeToggled value) darkModeToggled,
    required TResult Function(_QuietHoursToggled value) quietHoursToggled,
    required TResult Function(_DonationSubmitted value) donationSubmitted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult? Function(_NotificationsToggled value)? notificationsToggled,
    TResult? Function(_DarkModeToggled value)? darkModeToggled,
    TResult? Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult? Function(_DonationSubmitted value)? donationSubmitted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult Function(_NotificationsToggled value)? notificationsToggled,
    TResult Function(_DarkModeToggled value)? darkModeToggled,
    TResult Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult Function(_DonationSubmitted value)? donationSubmitted,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEventCopyWith<$Res> {
  factory $ProfileEventCopyWith(
    ProfileEvent value,
    $Res Function(ProfileEvent) then,
  ) = _$ProfileEventCopyWithImpl<$Res, ProfileEvent>;
}

/// @nodoc
class _$ProfileEventCopyWithImpl<$Res, $Val extends ProfileEvent>
    implements $ProfileEventCopyWith<$Res> {
  _$ProfileEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
    _$StartedImpl value,
    $Res Function(_$StartedImpl) then,
  ) = __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
    _$StartedImpl _value,
    $Res Function(_$StartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'ProfileEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() infoExpandedToggled,
    required TResult Function() notificationsToggled,
    required TResult Function() darkModeToggled,
    required TResult Function() quietHoursToggled,
    required TResult Function(String hospital, String bloodGroup, DateTime date)
    donationSubmitted,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? infoExpandedToggled,
    TResult? Function()? notificationsToggled,
    TResult? Function()? darkModeToggled,
    TResult? Function()? quietHoursToggled,
    TResult? Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? infoExpandedToggled,
    TResult Function()? notificationsToggled,
    TResult Function()? darkModeToggled,
    TResult Function()? quietHoursToggled,
    TResult Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_InfoExpandedToggled value) infoExpandedToggled,
    required TResult Function(_NotificationsToggled value) notificationsToggled,
    required TResult Function(_DarkModeToggled value) darkModeToggled,
    required TResult Function(_QuietHoursToggled value) quietHoursToggled,
    required TResult Function(_DonationSubmitted value) donationSubmitted,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult? Function(_NotificationsToggled value)? notificationsToggled,
    TResult? Function(_DarkModeToggled value)? darkModeToggled,
    TResult? Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult? Function(_DonationSubmitted value)? donationSubmitted,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult Function(_NotificationsToggled value)? notificationsToggled,
    TResult Function(_DarkModeToggled value)? darkModeToggled,
    TResult Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult Function(_DonationSubmitted value)? donationSubmitted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements ProfileEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$InfoExpandedToggledImplCopyWith<$Res> {
  factory _$$InfoExpandedToggledImplCopyWith(
    _$InfoExpandedToggledImpl value,
    $Res Function(_$InfoExpandedToggledImpl) then,
  ) = __$$InfoExpandedToggledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InfoExpandedToggledImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$InfoExpandedToggledImpl>
    implements _$$InfoExpandedToggledImplCopyWith<$Res> {
  __$$InfoExpandedToggledImplCopyWithImpl(
    _$InfoExpandedToggledImpl _value,
    $Res Function(_$InfoExpandedToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InfoExpandedToggledImpl implements _InfoExpandedToggled {
  const _$InfoExpandedToggledImpl();

  @override
  String toString() {
    return 'ProfileEvent.infoExpandedToggled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfoExpandedToggledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() infoExpandedToggled,
    required TResult Function() notificationsToggled,
    required TResult Function() darkModeToggled,
    required TResult Function() quietHoursToggled,
    required TResult Function(String hospital, String bloodGroup, DateTime date)
    donationSubmitted,
  }) {
    return infoExpandedToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? infoExpandedToggled,
    TResult? Function()? notificationsToggled,
    TResult? Function()? darkModeToggled,
    TResult? Function()? quietHoursToggled,
    TResult? Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
  }) {
    return infoExpandedToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? infoExpandedToggled,
    TResult Function()? notificationsToggled,
    TResult Function()? darkModeToggled,
    TResult Function()? quietHoursToggled,
    TResult Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
    required TResult orElse(),
  }) {
    if (infoExpandedToggled != null) {
      return infoExpandedToggled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_InfoExpandedToggled value) infoExpandedToggled,
    required TResult Function(_NotificationsToggled value) notificationsToggled,
    required TResult Function(_DarkModeToggled value) darkModeToggled,
    required TResult Function(_QuietHoursToggled value) quietHoursToggled,
    required TResult Function(_DonationSubmitted value) donationSubmitted,
  }) {
    return infoExpandedToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult? Function(_NotificationsToggled value)? notificationsToggled,
    TResult? Function(_DarkModeToggled value)? darkModeToggled,
    TResult? Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult? Function(_DonationSubmitted value)? donationSubmitted,
  }) {
    return infoExpandedToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult Function(_NotificationsToggled value)? notificationsToggled,
    TResult Function(_DarkModeToggled value)? darkModeToggled,
    TResult Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult Function(_DonationSubmitted value)? donationSubmitted,
    required TResult orElse(),
  }) {
    if (infoExpandedToggled != null) {
      return infoExpandedToggled(this);
    }
    return orElse();
  }
}

abstract class _InfoExpandedToggled implements ProfileEvent {
  const factory _InfoExpandedToggled() = _$InfoExpandedToggledImpl;
}

/// @nodoc
abstract class _$$NotificationsToggledImplCopyWith<$Res> {
  factory _$$NotificationsToggledImplCopyWith(
    _$NotificationsToggledImpl value,
    $Res Function(_$NotificationsToggledImpl) then,
  ) = __$$NotificationsToggledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationsToggledImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$NotificationsToggledImpl>
    implements _$$NotificationsToggledImplCopyWith<$Res> {
  __$$NotificationsToggledImplCopyWithImpl(
    _$NotificationsToggledImpl _value,
    $Res Function(_$NotificationsToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotificationsToggledImpl implements _NotificationsToggled {
  const _$NotificationsToggledImpl();

  @override
  String toString() {
    return 'ProfileEvent.notificationsToggled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsToggledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() infoExpandedToggled,
    required TResult Function() notificationsToggled,
    required TResult Function() darkModeToggled,
    required TResult Function() quietHoursToggled,
    required TResult Function(String hospital, String bloodGroup, DateTime date)
    donationSubmitted,
  }) {
    return notificationsToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? infoExpandedToggled,
    TResult? Function()? notificationsToggled,
    TResult? Function()? darkModeToggled,
    TResult? Function()? quietHoursToggled,
    TResult? Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
  }) {
    return notificationsToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? infoExpandedToggled,
    TResult Function()? notificationsToggled,
    TResult Function()? darkModeToggled,
    TResult Function()? quietHoursToggled,
    TResult Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
    required TResult orElse(),
  }) {
    if (notificationsToggled != null) {
      return notificationsToggled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_InfoExpandedToggled value) infoExpandedToggled,
    required TResult Function(_NotificationsToggled value) notificationsToggled,
    required TResult Function(_DarkModeToggled value) darkModeToggled,
    required TResult Function(_QuietHoursToggled value) quietHoursToggled,
    required TResult Function(_DonationSubmitted value) donationSubmitted,
  }) {
    return notificationsToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult? Function(_NotificationsToggled value)? notificationsToggled,
    TResult? Function(_DarkModeToggled value)? darkModeToggled,
    TResult? Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult? Function(_DonationSubmitted value)? donationSubmitted,
  }) {
    return notificationsToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult Function(_NotificationsToggled value)? notificationsToggled,
    TResult Function(_DarkModeToggled value)? darkModeToggled,
    TResult Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult Function(_DonationSubmitted value)? donationSubmitted,
    required TResult orElse(),
  }) {
    if (notificationsToggled != null) {
      return notificationsToggled(this);
    }
    return orElse();
  }
}

abstract class _NotificationsToggled implements ProfileEvent {
  const factory _NotificationsToggled() = _$NotificationsToggledImpl;
}

/// @nodoc
abstract class _$$DarkModeToggledImplCopyWith<$Res> {
  factory _$$DarkModeToggledImplCopyWith(
    _$DarkModeToggledImpl value,
    $Res Function(_$DarkModeToggledImpl) then,
  ) = __$$DarkModeToggledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DarkModeToggledImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$DarkModeToggledImpl>
    implements _$$DarkModeToggledImplCopyWith<$Res> {
  __$$DarkModeToggledImplCopyWithImpl(
    _$DarkModeToggledImpl _value,
    $Res Function(_$DarkModeToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DarkModeToggledImpl implements _DarkModeToggled {
  const _$DarkModeToggledImpl();

  @override
  String toString() {
    return 'ProfileEvent.darkModeToggled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DarkModeToggledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() infoExpandedToggled,
    required TResult Function() notificationsToggled,
    required TResult Function() darkModeToggled,
    required TResult Function() quietHoursToggled,
    required TResult Function(String hospital, String bloodGroup, DateTime date)
    donationSubmitted,
  }) {
    return darkModeToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? infoExpandedToggled,
    TResult? Function()? notificationsToggled,
    TResult? Function()? darkModeToggled,
    TResult? Function()? quietHoursToggled,
    TResult? Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
  }) {
    return darkModeToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? infoExpandedToggled,
    TResult Function()? notificationsToggled,
    TResult Function()? darkModeToggled,
    TResult Function()? quietHoursToggled,
    TResult Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
    required TResult orElse(),
  }) {
    if (darkModeToggled != null) {
      return darkModeToggled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_InfoExpandedToggled value) infoExpandedToggled,
    required TResult Function(_NotificationsToggled value) notificationsToggled,
    required TResult Function(_DarkModeToggled value) darkModeToggled,
    required TResult Function(_QuietHoursToggled value) quietHoursToggled,
    required TResult Function(_DonationSubmitted value) donationSubmitted,
  }) {
    return darkModeToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult? Function(_NotificationsToggled value)? notificationsToggled,
    TResult? Function(_DarkModeToggled value)? darkModeToggled,
    TResult? Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult? Function(_DonationSubmitted value)? donationSubmitted,
  }) {
    return darkModeToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult Function(_NotificationsToggled value)? notificationsToggled,
    TResult Function(_DarkModeToggled value)? darkModeToggled,
    TResult Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult Function(_DonationSubmitted value)? donationSubmitted,
    required TResult orElse(),
  }) {
    if (darkModeToggled != null) {
      return darkModeToggled(this);
    }
    return orElse();
  }
}

abstract class _DarkModeToggled implements ProfileEvent {
  const factory _DarkModeToggled() = _$DarkModeToggledImpl;
}

/// @nodoc
abstract class _$$QuietHoursToggledImplCopyWith<$Res> {
  factory _$$QuietHoursToggledImplCopyWith(
    _$QuietHoursToggledImpl value,
    $Res Function(_$QuietHoursToggledImpl) then,
  ) = __$$QuietHoursToggledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QuietHoursToggledImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$QuietHoursToggledImpl>
    implements _$$QuietHoursToggledImplCopyWith<$Res> {
  __$$QuietHoursToggledImplCopyWithImpl(
    _$QuietHoursToggledImpl _value,
    $Res Function(_$QuietHoursToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$QuietHoursToggledImpl implements _QuietHoursToggled {
  const _$QuietHoursToggledImpl();

  @override
  String toString() {
    return 'ProfileEvent.quietHoursToggled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$QuietHoursToggledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() infoExpandedToggled,
    required TResult Function() notificationsToggled,
    required TResult Function() darkModeToggled,
    required TResult Function() quietHoursToggled,
    required TResult Function(String hospital, String bloodGroup, DateTime date)
    donationSubmitted,
  }) {
    return quietHoursToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? infoExpandedToggled,
    TResult? Function()? notificationsToggled,
    TResult? Function()? darkModeToggled,
    TResult? Function()? quietHoursToggled,
    TResult? Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
  }) {
    return quietHoursToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? infoExpandedToggled,
    TResult Function()? notificationsToggled,
    TResult Function()? darkModeToggled,
    TResult Function()? quietHoursToggled,
    TResult Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
    required TResult orElse(),
  }) {
    if (quietHoursToggled != null) {
      return quietHoursToggled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_InfoExpandedToggled value) infoExpandedToggled,
    required TResult Function(_NotificationsToggled value) notificationsToggled,
    required TResult Function(_DarkModeToggled value) darkModeToggled,
    required TResult Function(_QuietHoursToggled value) quietHoursToggled,
    required TResult Function(_DonationSubmitted value) donationSubmitted,
  }) {
    return quietHoursToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult? Function(_NotificationsToggled value)? notificationsToggled,
    TResult? Function(_DarkModeToggled value)? darkModeToggled,
    TResult? Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult? Function(_DonationSubmitted value)? donationSubmitted,
  }) {
    return quietHoursToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult Function(_NotificationsToggled value)? notificationsToggled,
    TResult Function(_DarkModeToggled value)? darkModeToggled,
    TResult Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult Function(_DonationSubmitted value)? donationSubmitted,
    required TResult orElse(),
  }) {
    if (quietHoursToggled != null) {
      return quietHoursToggled(this);
    }
    return orElse();
  }
}

abstract class _QuietHoursToggled implements ProfileEvent {
  const factory _QuietHoursToggled() = _$QuietHoursToggledImpl;
}

/// @nodoc
abstract class _$$DonationSubmittedImplCopyWith<$Res> {
  factory _$$DonationSubmittedImplCopyWith(
    _$DonationSubmittedImpl value,
    $Res Function(_$DonationSubmittedImpl) then,
  ) = __$$DonationSubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String hospital, String bloodGroup, DateTime date});
}

/// @nodoc
class __$$DonationSubmittedImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$DonationSubmittedImpl>
    implements _$$DonationSubmittedImplCopyWith<$Res> {
  __$$DonationSubmittedImplCopyWithImpl(
    _$DonationSubmittedImpl _value,
    $Res Function(_$DonationSubmittedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hospital = null,
    Object? bloodGroup = null,
    Object? date = null,
  }) {
    return _then(
      _$DonationSubmittedImpl(
        hospital: null == hospital
            ? _value.hospital
            : hospital // ignore: cast_nullable_to_non_nullable
                  as String,
        bloodGroup: null == bloodGroup
            ? _value.bloodGroup
            : bloodGroup // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$DonationSubmittedImpl implements _DonationSubmitted {
  const _$DonationSubmittedImpl({
    required this.hospital,
    required this.bloodGroup,
    required this.date,
  });

  @override
  final String hospital;
  @override
  final String bloodGroup;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'ProfileEvent.donationSubmitted(hospital: $hospital, bloodGroup: $bloodGroup, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DonationSubmittedImpl &&
            (identical(other.hospital, hospital) ||
                other.hospital == hospital) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hospital, bloodGroup, date);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DonationSubmittedImplCopyWith<_$DonationSubmittedImpl> get copyWith =>
      __$$DonationSubmittedImplCopyWithImpl<_$DonationSubmittedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() infoExpandedToggled,
    required TResult Function() notificationsToggled,
    required TResult Function() darkModeToggled,
    required TResult Function() quietHoursToggled,
    required TResult Function(String hospital, String bloodGroup, DateTime date)
    donationSubmitted,
  }) {
    return donationSubmitted(hospital, bloodGroup, date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? infoExpandedToggled,
    TResult? Function()? notificationsToggled,
    TResult? Function()? darkModeToggled,
    TResult? Function()? quietHoursToggled,
    TResult? Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
  }) {
    return donationSubmitted?.call(hospital, bloodGroup, date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? infoExpandedToggled,
    TResult Function()? notificationsToggled,
    TResult Function()? darkModeToggled,
    TResult Function()? quietHoursToggled,
    TResult Function(String hospital, String bloodGroup, DateTime date)?
    donationSubmitted,
    required TResult orElse(),
  }) {
    if (donationSubmitted != null) {
      return donationSubmitted(hospital, bloodGroup, date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_InfoExpandedToggled value) infoExpandedToggled,
    required TResult Function(_NotificationsToggled value) notificationsToggled,
    required TResult Function(_DarkModeToggled value) darkModeToggled,
    required TResult Function(_QuietHoursToggled value) quietHoursToggled,
    required TResult Function(_DonationSubmitted value) donationSubmitted,
  }) {
    return donationSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult? Function(_NotificationsToggled value)? notificationsToggled,
    TResult? Function(_DarkModeToggled value)? darkModeToggled,
    TResult? Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult? Function(_DonationSubmitted value)? donationSubmitted,
  }) {
    return donationSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_InfoExpandedToggled value)? infoExpandedToggled,
    TResult Function(_NotificationsToggled value)? notificationsToggled,
    TResult Function(_DarkModeToggled value)? darkModeToggled,
    TResult Function(_QuietHoursToggled value)? quietHoursToggled,
    TResult Function(_DonationSubmitted value)? donationSubmitted,
    required TResult orElse(),
  }) {
    if (donationSubmitted != null) {
      return donationSubmitted(this);
    }
    return orElse();
  }
}

abstract class _DonationSubmitted implements ProfileEvent {
  const factory _DonationSubmitted({
    required final String hospital,
    required final String bloodGroup,
    required final DateTime date,
  }) = _$DonationSubmittedImpl;

  String get hospital;
  String get bloodGroup;
  DateTime get date;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DonationSubmittedImplCopyWith<_$DonationSubmittedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
