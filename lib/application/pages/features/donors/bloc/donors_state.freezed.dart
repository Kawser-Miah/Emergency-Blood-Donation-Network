// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'donors_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DonorsState {
  DonorsStatus get status => throw _privateConstructorUsedError;
  List<NearbyDonor> get donors => throw _privateConstructorUsedError;
  List<NearbyDonor> get filtered => throw _privateConstructorUsedError;
  bool get hasReachedMax => throw _privateConstructorUsedError;
  int get radiusIndex => throw _privateConstructorUsedError;
  String get search => throw _privateConstructorUsedError;
  String get selectedBloodGroup => throw _privateConstructorUsedError;
  String get selectedDistance => throw _privateConstructorUsedError;
  bool get showFilters => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of DonorsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DonorsStateCopyWith<DonorsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DonorsStateCopyWith<$Res> {
  factory $DonorsStateCopyWith(
    DonorsState value,
    $Res Function(DonorsState) then,
  ) = _$DonorsStateCopyWithImpl<$Res, DonorsState>;
  @useResult
  $Res call({
    DonorsStatus status,
    List<NearbyDonor> donors,
    List<NearbyDonor> filtered,
    bool hasReachedMax,
    int radiusIndex,
    String search,
    String selectedBloodGroup,
    String selectedDistance,
    bool showFilters,
    String? errorMessage,
  });
}

/// @nodoc
class _$DonorsStateCopyWithImpl<$Res, $Val extends DonorsState>
    implements $DonorsStateCopyWith<$Res> {
  _$DonorsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DonorsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? donors = null,
    Object? filtered = null,
    Object? hasReachedMax = null,
    Object? radiusIndex = null,
    Object? search = null,
    Object? selectedBloodGroup = null,
    Object? selectedDistance = null,
    Object? showFilters = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as DonorsStatus,
            donors: null == donors
                ? _value.donors
                : donors // ignore: cast_nullable_to_non_nullable
                      as List<NearbyDonor>,
            filtered: null == filtered
                ? _value.filtered
                : filtered // ignore: cast_nullable_to_non_nullable
                      as List<NearbyDonor>,
            hasReachedMax: null == hasReachedMax
                ? _value.hasReachedMax
                : hasReachedMax // ignore: cast_nullable_to_non_nullable
                      as bool,
            radiusIndex: null == radiusIndex
                ? _value.radiusIndex
                : radiusIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            search: null == search
                ? _value.search
                : search // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedBloodGroup: null == selectedBloodGroup
                ? _value.selectedBloodGroup
                : selectedBloodGroup // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedDistance: null == selectedDistance
                ? _value.selectedDistance
                : selectedDistance // ignore: cast_nullable_to_non_nullable
                      as String,
            showFilters: null == showFilters
                ? _value.showFilters
                : showFilters // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DonorsStateImplCopyWith<$Res>
    implements $DonorsStateCopyWith<$Res> {
  factory _$$DonorsStateImplCopyWith(
    _$DonorsStateImpl value,
    $Res Function(_$DonorsStateImpl) then,
  ) = __$$DonorsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DonorsStatus status,
    List<NearbyDonor> donors,
    List<NearbyDonor> filtered,
    bool hasReachedMax,
    int radiusIndex,
    String search,
    String selectedBloodGroup,
    String selectedDistance,
    bool showFilters,
    String? errorMessage,
  });
}

/// @nodoc
class __$$DonorsStateImplCopyWithImpl<$Res>
    extends _$DonorsStateCopyWithImpl<$Res, _$DonorsStateImpl>
    implements _$$DonorsStateImplCopyWith<$Res> {
  __$$DonorsStateImplCopyWithImpl(
    _$DonorsStateImpl _value,
    $Res Function(_$DonorsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DonorsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? donors = null,
    Object? filtered = null,
    Object? hasReachedMax = null,
    Object? radiusIndex = null,
    Object? search = null,
    Object? selectedBloodGroup = null,
    Object? selectedDistance = null,
    Object? showFilters = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$DonorsStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as DonorsStatus,
        donors: null == donors
            ? _value._donors
            : donors // ignore: cast_nullable_to_non_nullable
                  as List<NearbyDonor>,
        filtered: null == filtered
            ? _value._filtered
            : filtered // ignore: cast_nullable_to_non_nullable
                  as List<NearbyDonor>,
        hasReachedMax: null == hasReachedMax
            ? _value.hasReachedMax
            : hasReachedMax // ignore: cast_nullable_to_non_nullable
                  as bool,
        radiusIndex: null == radiusIndex
            ? _value.radiusIndex
            : radiusIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        search: null == search
            ? _value.search
            : search // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedBloodGroup: null == selectedBloodGroup
            ? _value.selectedBloodGroup
            : selectedBloodGroup // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedDistance: null == selectedDistance
            ? _value.selectedDistance
            : selectedDistance // ignore: cast_nullable_to_non_nullable
                  as String,
        showFilters: null == showFilters
            ? _value.showFilters
            : showFilters // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$DonorsStateImpl extends _DonorsState {
  const _$DonorsStateImpl({
    this.status = DonorsStatus.initial,
    final List<NearbyDonor> donors = const <NearbyDonor>[],
    final List<NearbyDonor> filtered = const <NearbyDonor>[],
    this.hasReachedMax = false,
    this.radiusIndex = 0,
    this.search = '',
    this.selectedBloodGroup = 'All',
    this.selectedDistance = 'All',
    this.showFilters = false,
    this.errorMessage,
  }) : _donors = donors,
       _filtered = filtered,
       super._();

  @override
  @JsonKey()
  final DonorsStatus status;
  final List<NearbyDonor> _donors;
  @override
  @JsonKey()
  List<NearbyDonor> get donors {
    if (_donors is EqualUnmodifiableListView) return _donors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_donors);
  }

  final List<NearbyDonor> _filtered;
  @override
  @JsonKey()
  List<NearbyDonor> get filtered {
    if (_filtered is EqualUnmodifiableListView) return _filtered;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filtered);
  }

  @override
  @JsonKey()
  final bool hasReachedMax;
  @override
  @JsonKey()
  final int radiusIndex;
  @override
  @JsonKey()
  final String search;
  @override
  @JsonKey()
  final String selectedBloodGroup;
  @override
  @JsonKey()
  final String selectedDistance;
  @override
  @JsonKey()
  final bool showFilters;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'DonorsState(status: $status, donors: $donors, filtered: $filtered, hasReachedMax: $hasReachedMax, radiusIndex: $radiusIndex, search: $search, selectedBloodGroup: $selectedBloodGroup, selectedDistance: $selectedDistance, showFilters: $showFilters, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DonorsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._donors, _donors) &&
            const DeepCollectionEquality().equals(other._filtered, _filtered) &&
            (identical(other.hasReachedMax, hasReachedMax) ||
                other.hasReachedMax == hasReachedMax) &&
            (identical(other.radiusIndex, radiusIndex) ||
                other.radiusIndex == radiusIndex) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.selectedBloodGroup, selectedBloodGroup) ||
                other.selectedBloodGroup == selectedBloodGroup) &&
            (identical(other.selectedDistance, selectedDistance) ||
                other.selectedDistance == selectedDistance) &&
            (identical(other.showFilters, showFilters) ||
                other.showFilters == showFilters) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_donors),
    const DeepCollectionEquality().hash(_filtered),
    hasReachedMax,
    radiusIndex,
    search,
    selectedBloodGroup,
    selectedDistance,
    showFilters,
    errorMessage,
  );

  /// Create a copy of DonorsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DonorsStateImplCopyWith<_$DonorsStateImpl> get copyWith =>
      __$$DonorsStateImplCopyWithImpl<_$DonorsStateImpl>(this, _$identity);
}

abstract class _DonorsState extends DonorsState {
  const factory _DonorsState({
    final DonorsStatus status,
    final List<NearbyDonor> donors,
    final List<NearbyDonor> filtered,
    final bool hasReachedMax,
    final int radiusIndex,
    final String search,
    final String selectedBloodGroup,
    final String selectedDistance,
    final bool showFilters,
    final String? errorMessage,
  }) = _$DonorsStateImpl;
  const _DonorsState._() : super._();

  @override
  DonorsStatus get status;
  @override
  List<NearbyDonor> get donors;
  @override
  List<NearbyDonor> get filtered;
  @override
  bool get hasReachedMax;
  @override
  int get radiusIndex;
  @override
  String get search;
  @override
  String get selectedBloodGroup;
  @override
  String get selectedDistance;
  @override
  bool get showFilters;
  @override
  String? get errorMessage;

  /// Create a copy of DonorsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DonorsStateImplCopyWith<_$DonorsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
