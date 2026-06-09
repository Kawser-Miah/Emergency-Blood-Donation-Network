// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProfileState {
  bool get isLoading => throw _privateConstructorUsedError;
  UserProfileModel? get profile => throw _privateConstructorUsedError;
  List<DonationHistoryEntry> get donationHistory =>
      throw _privateConstructorUsedError;
  bool get infoExpanded => throw _privateConstructorUsedError;
  bool get notifications => throw _privateConstructorUsedError;
  bool get darkMode => throw _privateConstructorUsedError;
  bool get quietHours => throw _privateConstructorUsedError;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
    ProfileState value,
    $Res Function(ProfileState) then,
  ) = _$ProfileStateCopyWithImpl<$Res, ProfileState>;
  @useResult
  $Res call({
    bool isLoading,
    UserProfileModel? profile,
    List<DonationHistoryEntry> donationHistory,
    bool infoExpanded,
    bool notifications,
    bool darkMode,
    bool quietHours,
  });
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? profile = freezed,
    Object? donationHistory = null,
    Object? infoExpanded = null,
    Object? notifications = null,
    Object? darkMode = null,
    Object? quietHours = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            profile: freezed == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                      as UserProfileModel?,
            donationHistory: null == donationHistory
                ? _value.donationHistory
                : donationHistory // ignore: cast_nullable_to_non_nullable
                      as List<DonationHistoryEntry>,
            infoExpanded: null == infoExpanded
                ? _value.infoExpanded
                : infoExpanded // ignore: cast_nullable_to_non_nullable
                      as bool,
            notifications: null == notifications
                ? _value.notifications
                : notifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            darkMode: null == darkMode
                ? _value.darkMode
                : darkMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            quietHours: null == quietHours
                ? _value.quietHours
                : quietHours // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileStateImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$ProfileStateImplCopyWith(
    _$ProfileStateImpl value,
    $Res Function(_$ProfileStateImpl) then,
  ) = __$$ProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    UserProfileModel? profile,
    List<DonationHistoryEntry> donationHistory,
    bool infoExpanded,
    bool notifications,
    bool darkMode,
    bool quietHours,
  });
}

/// @nodoc
class __$$ProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileStateImpl>
    implements _$$ProfileStateImplCopyWith<$Res> {
  __$$ProfileStateImplCopyWithImpl(
    _$ProfileStateImpl _value,
    $Res Function(_$ProfileStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? profile = freezed,
    Object? donationHistory = null,
    Object? infoExpanded = null,
    Object? notifications = null,
    Object? darkMode = null,
    Object? quietHours = null,
  }) {
    return _then(
      _$ProfileStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        profile: freezed == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as UserProfileModel?,
        donationHistory: null == donationHistory
            ? _value.donationHistory
            : donationHistory // ignore: cast_nullable_to_non_nullable
                  as List<DonationHistoryEntry>,
        infoExpanded: null == infoExpanded
            ? _value.infoExpanded
            : infoExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
        notifications: null == notifications
            ? _value.notifications
            : notifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        darkMode: null == darkMode
            ? _value.darkMode
            : darkMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        quietHours: null == quietHours
            ? _value.quietHours
            : quietHours // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ProfileStateImpl implements _ProfileState {
  const _$ProfileStateImpl({
    this.isLoading = false,
    this.profile,
    this.donationHistory = const <DonationHistoryEntry>[],
    this.infoExpanded = true,
    this.notifications = true,
    this.darkMode = false,
    this.quietHours = true,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final UserProfileModel? profile;
  @override
  @JsonKey()
  final List<DonationHistoryEntry> donationHistory;
  @override
  @JsonKey()
  final bool infoExpanded;
  @override
  @JsonKey()
  final bool notifications;
  @override
  @JsonKey()
  final bool darkMode;
  @override
  @JsonKey()
  final bool quietHours;

  @override
  String toString() {
    return 'ProfileState(isLoading: $isLoading, profile: $profile, donationHistory: $donationHistory, infoExpanded: $infoExpanded, notifications: $notifications, darkMode: $darkMode, quietHours: $quietHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            const DeepCollectionEquality().equals(
              other.donationHistory,
              donationHistory,
            ) &&
            (identical(other.infoExpanded, infoExpanded) ||
                other.infoExpanded == infoExpanded) &&
            (identical(other.notifications, notifications) ||
                other.notifications == notifications) &&
            (identical(other.darkMode, darkMode) ||
                other.darkMode == darkMode) &&
            (identical(other.quietHours, quietHours) ||
                other.quietHours == quietHours));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    profile,
    const DeepCollectionEquality().hash(donationHistory),
    infoExpanded,
    notifications,
    darkMode,
    quietHours,
  );

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      __$$ProfileStateImplCopyWithImpl<_$ProfileStateImpl>(this, _$identity);
}

abstract class _ProfileState implements ProfileState {
  const factory _ProfileState({
    final bool isLoading,
    final UserProfileModel? profile,
    final List<DonationHistoryEntry> donationHistory,
    final bool infoExpanded,
    final bool notifications,
    final bool darkMode,
    final bool quietHours,
  }) = _$ProfileStateImpl;

  @override
  bool get isLoading;
  @override
  UserProfileModel? get profile;
  @override
  List<DonationHistoryEntry> get donationHistory;
  @override
  bool get infoExpanded;
  @override
  bool get notifications;
  @override
  bool get darkMode;
  @override
  bool get quietHours;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
