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
  List<NearbyDonor> get donors => throw _privateConstructorUsedError;
  List<NearbyDonor> get filtered => throw _privateConstructorUsedError;
  double get currentRadiusKm => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  String get search => throw _privateConstructorUsedError;
  String get selectedBloodGroup => throw _privateConstructorUsedError;
  String get selectedDistance => throw _privateConstructorUsedError;
  bool get showFilters => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

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
    List<NearbyDonor> donors,
    List<NearbyDonor> filtered,
    double currentRadiusKm,
    bool hasMore,
    bool isLoading,
    bool isLoadingMore,
    String search,
    String selectedBloodGroup,
    String selectedDistance,
    bool showFilters,
    String? error,
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
    Object? donors = null,
    Object? filtered = null,
    Object? currentRadiusKm = null,
    Object? hasMore = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? search = null,
    Object? selectedBloodGroup = null,
    Object? selectedDistance = null,
    Object? showFilters = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            donors: null == donors
                ? _value.donors
                : donors // ignore: cast_nullable_to_non_nullable
                      as List<NearbyDonor>,
            filtered: null == filtered
                ? _value.filtered
                : filtered // ignore: cast_nullable_to_non_nullable
                      as List<NearbyDonor>,
            currentRadiusKm: null == currentRadiusKm
                ? _value.currentRadiusKm
                : currentRadiusKm // ignore: cast_nullable_to_non_nullable
                      as double,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
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
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
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
    List<NearbyDonor> donors,
    List<NearbyDonor> filtered,
    double currentRadiusKm,
    bool hasMore,
    bool isLoading,
    bool isLoadingMore,
    String search,
    String selectedBloodGroup,
    String selectedDistance,
    bool showFilters,
    String? error,
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
    Object? donors = null,
    Object? filtered = null,
    Object? currentRadiusKm = null,
    Object? hasMore = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? search = null,
    Object? selectedBloodGroup = null,
    Object? selectedDistance = null,
    Object? showFilters = null,
    Object? error = freezed,
  }) {
    return _then(
      _$DonorsStateImpl(
        donors: null == donors
            ? _value._donors
            : donors // ignore: cast_nullable_to_non_nullable
                  as List<NearbyDonor>,
        filtered: null == filtered
            ? _value._filtered
            : filtered // ignore: cast_nullable_to_non_nullable
                  as List<NearbyDonor>,
        currentRadiusKm: null == currentRadiusKm
            ? _value.currentRadiusKm
            : currentRadiusKm // ignore: cast_nullable_to_non_nullable
                  as double,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
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
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$DonorsStateImpl extends _DonorsState {
  const _$DonorsStateImpl({
    final List<NearbyDonor> donors = const <NearbyDonor>[],
    final List<NearbyDonor> filtered = const <NearbyDonor>[],
    this.currentRadiusKm = 0.0,
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.search = '',
    this.selectedBloodGroup = 'All',
    this.selectedDistance = 'All',
    this.showFilters = false,
    this.error,
  }) : _donors = donors,
       _filtered = filtered,
       super._();

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
  final double currentRadiusKm;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
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
  final String? error;

  @override
  String toString() {
    return 'DonorsState(donors: $donors, filtered: $filtered, currentRadiusKm: $currentRadiusKm, hasMore: $hasMore, isLoading: $isLoading, isLoadingMore: $isLoadingMore, search: $search, selectedBloodGroup: $selectedBloodGroup, selectedDistance: $selectedDistance, showFilters: $showFilters, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DonorsStateImpl &&
            const DeepCollectionEquality().equals(other._donors, _donors) &&
            const DeepCollectionEquality().equals(other._filtered, _filtered) &&
            (identical(other.currentRadiusKm, currentRadiusKm) ||
                other.currentRadiusKm == currentRadiusKm) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.selectedBloodGroup, selectedBloodGroup) ||
                other.selectedBloodGroup == selectedBloodGroup) &&
            (identical(other.selectedDistance, selectedDistance) ||
                other.selectedDistance == selectedDistance) &&
            (identical(other.showFilters, showFilters) ||
                other.showFilters == showFilters) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_donors),
    const DeepCollectionEquality().hash(_filtered),
    currentRadiusKm,
    hasMore,
    isLoading,
    isLoadingMore,
    search,
    selectedBloodGroup,
    selectedDistance,
    showFilters,
    error,
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
    final List<NearbyDonor> donors,
    final List<NearbyDonor> filtered,
    final double currentRadiusKm,
    final bool hasMore,
    final bool isLoading,
    final bool isLoadingMore,
    final String search,
    final String selectedBloodGroup,
    final String selectedDistance,
    final bool showFilters,
    final String? error,
  }) = _$DonorsStateImpl;
  const _DonorsState._() : super._();

  @override
  List<NearbyDonor> get donors;
  @override
  List<NearbyDonor> get filtered;
  @override
  double get currentRadiusKm;
  @override
  bool get hasMore;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  String get search;
  @override
  String get selectedBloodGroup;
  @override
  String get selectedDistance;
  @override
  bool get showFilters;
  @override
  String? get error;

  /// Create a copy of DonorsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DonorsStateImplCopyWith<_$DonorsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
