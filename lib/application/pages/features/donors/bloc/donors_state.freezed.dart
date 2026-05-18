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
  String get search => throw _privateConstructorUsedError;
  String get selectedBloodGroup => throw _privateConstructorUsedError;
  String get selectedDistance => throw _privateConstructorUsedError;
  double get minRating => throw _privateConstructorUsedError;
  bool get showFilters => throw _privateConstructorUsedError;
  List<Donor> get filtered => throw _privateConstructorUsedError;

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
    String search,
    String selectedBloodGroup,
    String selectedDistance,
    double minRating,
    bool showFilters,
    List<Donor> filtered,
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
    Object? search = null,
    Object? selectedBloodGroup = null,
    Object? selectedDistance = null,
    Object? minRating = null,
    Object? showFilters = null,
    Object? filtered = null,
  }) {
    return _then(
      _value.copyWith(
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
            minRating: null == minRating
                ? _value.minRating
                : minRating // ignore: cast_nullable_to_non_nullable
                      as double,
            showFilters: null == showFilters
                ? _value.showFilters
                : showFilters // ignore: cast_nullable_to_non_nullable
                      as bool,
            filtered: null == filtered
                ? _value.filtered
                : filtered // ignore: cast_nullable_to_non_nullable
                      as List<Donor>,
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
    String search,
    String selectedBloodGroup,
    String selectedDistance,
    double minRating,
    bool showFilters,
    List<Donor> filtered,
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
    Object? search = null,
    Object? selectedBloodGroup = null,
    Object? selectedDistance = null,
    Object? minRating = null,
    Object? showFilters = null,
    Object? filtered = null,
  }) {
    return _then(
      _$DonorsStateImpl(
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
        minRating: null == minRating
            ? _value.minRating
            : minRating // ignore: cast_nullable_to_non_nullable
                  as double,
        showFilters: null == showFilters
            ? _value.showFilters
            : showFilters // ignore: cast_nullable_to_non_nullable
                  as bool,
        filtered: null == filtered
            ? _value._filtered
            : filtered // ignore: cast_nullable_to_non_nullable
                  as List<Donor>,
      ),
    );
  }
}

/// @nodoc

class _$DonorsStateImpl implements _DonorsState {
  const _$DonorsStateImpl({
    this.search = '',
    this.selectedBloodGroup = 'All',
    this.selectedDistance = 'All',
    this.minRating = 0.0,
    this.showFilters = false,
    final List<Donor> filtered = const <Donor>[],
  }) : _filtered = filtered;

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
  final double minRating;
  @override
  @JsonKey()
  final bool showFilters;
  final List<Donor> _filtered;
  @override
  @JsonKey()
  List<Donor> get filtered {
    if (_filtered is EqualUnmodifiableListView) return _filtered;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filtered);
  }

  @override
  String toString() {
    return 'DonorsState(search: $search, selectedBloodGroup: $selectedBloodGroup, selectedDistance: $selectedDistance, minRating: $minRating, showFilters: $showFilters, filtered: $filtered)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DonorsStateImpl &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.selectedBloodGroup, selectedBloodGroup) ||
                other.selectedBloodGroup == selectedBloodGroup) &&
            (identical(other.selectedDistance, selectedDistance) ||
                other.selectedDistance == selectedDistance) &&
            (identical(other.minRating, minRating) ||
                other.minRating == minRating) &&
            (identical(other.showFilters, showFilters) ||
                other.showFilters == showFilters) &&
            const DeepCollectionEquality().equals(other._filtered, _filtered));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    search,
    selectedBloodGroup,
    selectedDistance,
    minRating,
    showFilters,
    const DeepCollectionEquality().hash(_filtered),
  );

  /// Create a copy of DonorsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DonorsStateImplCopyWith<_$DonorsStateImpl> get copyWith =>
      __$$DonorsStateImplCopyWithImpl<_$DonorsStateImpl>(this, _$identity);
}

abstract class _DonorsState implements DonorsState {
  const factory _DonorsState({
    final String search,
    final String selectedBloodGroup,
    final String selectedDistance,
    final double minRating,
    final bool showFilters,
    final List<Donor> filtered,
  }) = _$DonorsStateImpl;

  @override
  String get search;
  @override
  String get selectedBloodGroup;
  @override
  String get selectedDistance;
  @override
  double get minRating;
  @override
  bool get showFilters;
  @override
  List<Donor> get filtered;

  /// Create a copy of DonorsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DonorsStateImplCopyWith<_$DonorsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
