// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeState {
  bool get showSidebar => throw _privateConstructorUsedError;
  bool get sosPressed => throw _privateConstructorUsedError;
  UserProfileModel? get profile => throw _privateConstructorUsedError;
  List<NearbyDonor> get nearbyDonors => throw _privateConstructorUsedError;
  bool get isLoadingNearby => throw _privateConstructorUsedError;
  String? get nearbyError => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call({
    bool showSidebar,
    bool sosPressed,
    UserProfileModel? profile,
    List<NearbyDonor> nearbyDonors,
    bool isLoadingNearby,
    String? nearbyError,
  });
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showSidebar = null,
    Object? sosPressed = null,
    Object? profile = freezed,
    Object? nearbyDonors = null,
    Object? isLoadingNearby = null,
    Object? nearbyError = freezed,
  }) {
    return _then(
      _value.copyWith(
            showSidebar: null == showSidebar
                ? _value.showSidebar
                : showSidebar // ignore: cast_nullable_to_non_nullable
                      as bool,
            sosPressed: null == sosPressed
                ? _value.sosPressed
                : sosPressed // ignore: cast_nullable_to_non_nullable
                      as bool,
            profile: freezed == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                      as UserProfileModel?,
            nearbyDonors: null == nearbyDonors
                ? _value.nearbyDonors
                : nearbyDonors // ignore: cast_nullable_to_non_nullable
                      as List<NearbyDonor>,
            isLoadingNearby: null == isLoadingNearby
                ? _value.isLoadingNearby
                : isLoadingNearby // ignore: cast_nullable_to_non_nullable
                      as bool,
            nearbyError: freezed == nearbyError
                ? _value.nearbyError
                : nearbyError // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
    _$HomeStateImpl value,
    $Res Function(_$HomeStateImpl) then,
  ) = __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool showSidebar,
    bool sosPressed,
    UserProfileModel? profile,
    List<NearbyDonor> nearbyDonors,
    bool isLoadingNearby,
    String? nearbyError,
  });
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
    _$HomeStateImpl _value,
    $Res Function(_$HomeStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showSidebar = null,
    Object? sosPressed = null,
    Object? profile = freezed,
    Object? nearbyDonors = null,
    Object? isLoadingNearby = null,
    Object? nearbyError = freezed,
  }) {
    return _then(
      _$HomeStateImpl(
        showSidebar: null == showSidebar
            ? _value.showSidebar
            : showSidebar // ignore: cast_nullable_to_non_nullable
                  as bool,
        sosPressed: null == sosPressed
            ? _value.sosPressed
            : sosPressed // ignore: cast_nullable_to_non_nullable
                  as bool,
        profile: freezed == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as UserProfileModel?,
        nearbyDonors: null == nearbyDonors
            ? _value._nearbyDonors
            : nearbyDonors // ignore: cast_nullable_to_non_nullable
                  as List<NearbyDonor>,
        isLoadingNearby: null == isLoadingNearby
            ? _value.isLoadingNearby
            : isLoadingNearby // ignore: cast_nullable_to_non_nullable
                  as bool,
        nearbyError: freezed == nearbyError
            ? _value.nearbyError
            : nearbyError // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl({
    this.showSidebar = false,
    this.sosPressed = false,
    this.profile,
    final List<NearbyDonor> nearbyDonors = const <NearbyDonor>[],
    this.isLoadingNearby = true,
    this.nearbyError,
  }) : _nearbyDonors = nearbyDonors;

  @override
  @JsonKey()
  final bool showSidebar;
  @override
  @JsonKey()
  final bool sosPressed;
  @override
  final UserProfileModel? profile;
  final List<NearbyDonor> _nearbyDonors;
  @override
  @JsonKey()
  List<NearbyDonor> get nearbyDonors {
    if (_nearbyDonors is EqualUnmodifiableListView) return _nearbyDonors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nearbyDonors);
  }

  @override
  @JsonKey()
  final bool isLoadingNearby;
  @override
  final String? nearbyError;

  @override
  String toString() {
    return 'HomeState(showSidebar: $showSidebar, sosPressed: $sosPressed, profile: $profile, nearbyDonors: $nearbyDonors, isLoadingNearby: $isLoadingNearby, nearbyError: $nearbyError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.showSidebar, showSidebar) ||
                other.showSidebar == showSidebar) &&
            (identical(other.sosPressed, sosPressed) ||
                other.sosPressed == sosPressed) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            const DeepCollectionEquality().equals(
              other._nearbyDonors,
              _nearbyDonors,
            ) &&
            (identical(other.isLoadingNearby, isLoadingNearby) ||
                other.isLoadingNearby == isLoadingNearby) &&
            (identical(other.nearbyError, nearbyError) ||
                other.nearbyError == nearbyError));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    showSidebar,
    sosPressed,
    profile,
    const DeepCollectionEquality().hash(_nearbyDonors),
    isLoadingNearby,
    nearbyError,
  );

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState({
    final bool showSidebar,
    final bool sosPressed,
    final UserProfileModel? profile,
    final List<NearbyDonor> nearbyDonors,
    final bool isLoadingNearby,
    final String? nearbyError,
  }) = _$HomeStateImpl;

  @override
  bool get showSidebar;
  @override
  bool get sosPressed;
  @override
  UserProfileModel? get profile;
  @override
  List<NearbyDonor> get nearbyDonors;
  @override
  bool get isLoadingNearby;
  @override
  String? get nearbyError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
