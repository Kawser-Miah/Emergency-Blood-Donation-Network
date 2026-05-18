// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'donors_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DonorsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) searchChanged,
    required TResult Function(String value) bloodGroupSelected,
    required TResult Function(String value) distanceSelected,
    required TResult Function(double value) ratingSelected,
    required TResult Function() filtersOpened,
    required TResult Function() filtersClosed,
    required TResult Function() filtersReset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? searchChanged,
    TResult? Function(String value)? bloodGroupSelected,
    TResult? Function(String value)? distanceSelected,
    TResult? Function(double value)? ratingSelected,
    TResult? Function()? filtersOpened,
    TResult? Function()? filtersClosed,
    TResult? Function()? filtersReset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? searchChanged,
    TResult Function(String value)? bloodGroupSelected,
    TResult Function(String value)? distanceSelected,
    TResult Function(double value)? ratingSelected,
    TResult Function()? filtersOpened,
    TResult Function()? filtersClosed,
    TResult Function()? filtersReset,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_BloodGroupSelected value) bloodGroupSelected,
    required TResult Function(_DistanceSelected value) distanceSelected,
    required TResult Function(_RatingSelected value) ratingSelected,
    required TResult Function(_FiltersOpened value) filtersOpened,
    required TResult Function(_FiltersClosed value) filtersClosed,
    required TResult Function(_FiltersReset value) filtersReset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult? Function(_DistanceSelected value)? distanceSelected,
    TResult? Function(_RatingSelected value)? ratingSelected,
    TResult? Function(_FiltersOpened value)? filtersOpened,
    TResult? Function(_FiltersClosed value)? filtersClosed,
    TResult? Function(_FiltersReset value)? filtersReset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult Function(_DistanceSelected value)? distanceSelected,
    TResult Function(_RatingSelected value)? ratingSelected,
    TResult Function(_FiltersOpened value)? filtersOpened,
    TResult Function(_FiltersClosed value)? filtersClosed,
    TResult Function(_FiltersReset value)? filtersReset,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DonorsEventCopyWith<$Res> {
  factory $DonorsEventCopyWith(
    DonorsEvent value,
    $Res Function(DonorsEvent) then,
  ) = _$DonorsEventCopyWithImpl<$Res, DonorsEvent>;
}

/// @nodoc
class _$DonorsEventCopyWithImpl<$Res, $Val extends DonorsEvent>
    implements $DonorsEventCopyWith<$Res> {
  _$DonorsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SearchChangedImplCopyWith<$Res> {
  factory _$$SearchChangedImplCopyWith(
    _$SearchChangedImpl value,
    $Res Function(_$SearchChangedImpl) then,
  ) = __$$SearchChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$SearchChangedImplCopyWithImpl<$Res>
    extends _$DonorsEventCopyWithImpl<$Res, _$SearchChangedImpl>
    implements _$$SearchChangedImplCopyWith<$Res> {
  __$$SearchChangedImplCopyWithImpl(
    _$SearchChangedImpl _value,
    $Res Function(_$SearchChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$SearchChangedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchChangedImpl implements _SearchChanged {
  const _$SearchChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'DonorsEvent.searchChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchChangedImplCopyWith<_$SearchChangedImpl> get copyWith =>
      __$$SearchChangedImplCopyWithImpl<_$SearchChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) searchChanged,
    required TResult Function(String value) bloodGroupSelected,
    required TResult Function(String value) distanceSelected,
    required TResult Function(double value) ratingSelected,
    required TResult Function() filtersOpened,
    required TResult Function() filtersClosed,
    required TResult Function() filtersReset,
  }) {
    return searchChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? searchChanged,
    TResult? Function(String value)? bloodGroupSelected,
    TResult? Function(String value)? distanceSelected,
    TResult? Function(double value)? ratingSelected,
    TResult? Function()? filtersOpened,
    TResult? Function()? filtersClosed,
    TResult? Function()? filtersReset,
  }) {
    return searchChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? searchChanged,
    TResult Function(String value)? bloodGroupSelected,
    TResult Function(String value)? distanceSelected,
    TResult Function(double value)? ratingSelected,
    TResult Function()? filtersOpened,
    TResult Function()? filtersClosed,
    TResult Function()? filtersReset,
    required TResult orElse(),
  }) {
    if (searchChanged != null) {
      return searchChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_BloodGroupSelected value) bloodGroupSelected,
    required TResult Function(_DistanceSelected value) distanceSelected,
    required TResult Function(_RatingSelected value) ratingSelected,
    required TResult Function(_FiltersOpened value) filtersOpened,
    required TResult Function(_FiltersClosed value) filtersClosed,
    required TResult Function(_FiltersReset value) filtersReset,
  }) {
    return searchChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult? Function(_DistanceSelected value)? distanceSelected,
    TResult? Function(_RatingSelected value)? ratingSelected,
    TResult? Function(_FiltersOpened value)? filtersOpened,
    TResult? Function(_FiltersClosed value)? filtersClosed,
    TResult? Function(_FiltersReset value)? filtersReset,
  }) {
    return searchChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult Function(_DistanceSelected value)? distanceSelected,
    TResult Function(_RatingSelected value)? ratingSelected,
    TResult Function(_FiltersOpened value)? filtersOpened,
    TResult Function(_FiltersClosed value)? filtersClosed,
    TResult Function(_FiltersReset value)? filtersReset,
    required TResult orElse(),
  }) {
    if (searchChanged != null) {
      return searchChanged(this);
    }
    return orElse();
  }
}

abstract class _SearchChanged implements DonorsEvent {
  const factory _SearchChanged(final String value) = _$SearchChangedImpl;

  String get value;

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchChangedImplCopyWith<_$SearchChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BloodGroupSelectedImplCopyWith<$Res> {
  factory _$$BloodGroupSelectedImplCopyWith(
    _$BloodGroupSelectedImpl value,
    $Res Function(_$BloodGroupSelectedImpl) then,
  ) = __$$BloodGroupSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$BloodGroupSelectedImplCopyWithImpl<$Res>
    extends _$DonorsEventCopyWithImpl<$Res, _$BloodGroupSelectedImpl>
    implements _$$BloodGroupSelectedImplCopyWith<$Res> {
  __$$BloodGroupSelectedImplCopyWithImpl(
    _$BloodGroupSelectedImpl _value,
    $Res Function(_$BloodGroupSelectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$BloodGroupSelectedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$BloodGroupSelectedImpl implements _BloodGroupSelected {
  const _$BloodGroupSelectedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'DonorsEvent.bloodGroupSelected(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BloodGroupSelectedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BloodGroupSelectedImplCopyWith<_$BloodGroupSelectedImpl> get copyWith =>
      __$$BloodGroupSelectedImplCopyWithImpl<_$BloodGroupSelectedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) searchChanged,
    required TResult Function(String value) bloodGroupSelected,
    required TResult Function(String value) distanceSelected,
    required TResult Function(double value) ratingSelected,
    required TResult Function() filtersOpened,
    required TResult Function() filtersClosed,
    required TResult Function() filtersReset,
  }) {
    return bloodGroupSelected(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? searchChanged,
    TResult? Function(String value)? bloodGroupSelected,
    TResult? Function(String value)? distanceSelected,
    TResult? Function(double value)? ratingSelected,
    TResult? Function()? filtersOpened,
    TResult? Function()? filtersClosed,
    TResult? Function()? filtersReset,
  }) {
    return bloodGroupSelected?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? searchChanged,
    TResult Function(String value)? bloodGroupSelected,
    TResult Function(String value)? distanceSelected,
    TResult Function(double value)? ratingSelected,
    TResult Function()? filtersOpened,
    TResult Function()? filtersClosed,
    TResult Function()? filtersReset,
    required TResult orElse(),
  }) {
    if (bloodGroupSelected != null) {
      return bloodGroupSelected(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_BloodGroupSelected value) bloodGroupSelected,
    required TResult Function(_DistanceSelected value) distanceSelected,
    required TResult Function(_RatingSelected value) ratingSelected,
    required TResult Function(_FiltersOpened value) filtersOpened,
    required TResult Function(_FiltersClosed value) filtersClosed,
    required TResult Function(_FiltersReset value) filtersReset,
  }) {
    return bloodGroupSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult? Function(_DistanceSelected value)? distanceSelected,
    TResult? Function(_RatingSelected value)? ratingSelected,
    TResult? Function(_FiltersOpened value)? filtersOpened,
    TResult? Function(_FiltersClosed value)? filtersClosed,
    TResult? Function(_FiltersReset value)? filtersReset,
  }) {
    return bloodGroupSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult Function(_DistanceSelected value)? distanceSelected,
    TResult Function(_RatingSelected value)? ratingSelected,
    TResult Function(_FiltersOpened value)? filtersOpened,
    TResult Function(_FiltersClosed value)? filtersClosed,
    TResult Function(_FiltersReset value)? filtersReset,
    required TResult orElse(),
  }) {
    if (bloodGroupSelected != null) {
      return bloodGroupSelected(this);
    }
    return orElse();
  }
}

abstract class _BloodGroupSelected implements DonorsEvent {
  const factory _BloodGroupSelected(final String value) =
      _$BloodGroupSelectedImpl;

  String get value;

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BloodGroupSelectedImplCopyWith<_$BloodGroupSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DistanceSelectedImplCopyWith<$Res> {
  factory _$$DistanceSelectedImplCopyWith(
    _$DistanceSelectedImpl value,
    $Res Function(_$DistanceSelectedImpl) then,
  ) = __$$DistanceSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$DistanceSelectedImplCopyWithImpl<$Res>
    extends _$DonorsEventCopyWithImpl<$Res, _$DistanceSelectedImpl>
    implements _$$DistanceSelectedImplCopyWith<$Res> {
  __$$DistanceSelectedImplCopyWithImpl(
    _$DistanceSelectedImpl _value,
    $Res Function(_$DistanceSelectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$DistanceSelectedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DistanceSelectedImpl implements _DistanceSelected {
  const _$DistanceSelectedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'DonorsEvent.distanceSelected(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DistanceSelectedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DistanceSelectedImplCopyWith<_$DistanceSelectedImpl> get copyWith =>
      __$$DistanceSelectedImplCopyWithImpl<_$DistanceSelectedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) searchChanged,
    required TResult Function(String value) bloodGroupSelected,
    required TResult Function(String value) distanceSelected,
    required TResult Function(double value) ratingSelected,
    required TResult Function() filtersOpened,
    required TResult Function() filtersClosed,
    required TResult Function() filtersReset,
  }) {
    return distanceSelected(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? searchChanged,
    TResult? Function(String value)? bloodGroupSelected,
    TResult? Function(String value)? distanceSelected,
    TResult? Function(double value)? ratingSelected,
    TResult? Function()? filtersOpened,
    TResult? Function()? filtersClosed,
    TResult? Function()? filtersReset,
  }) {
    return distanceSelected?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? searchChanged,
    TResult Function(String value)? bloodGroupSelected,
    TResult Function(String value)? distanceSelected,
    TResult Function(double value)? ratingSelected,
    TResult Function()? filtersOpened,
    TResult Function()? filtersClosed,
    TResult Function()? filtersReset,
    required TResult orElse(),
  }) {
    if (distanceSelected != null) {
      return distanceSelected(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_BloodGroupSelected value) bloodGroupSelected,
    required TResult Function(_DistanceSelected value) distanceSelected,
    required TResult Function(_RatingSelected value) ratingSelected,
    required TResult Function(_FiltersOpened value) filtersOpened,
    required TResult Function(_FiltersClosed value) filtersClosed,
    required TResult Function(_FiltersReset value) filtersReset,
  }) {
    return distanceSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult? Function(_DistanceSelected value)? distanceSelected,
    TResult? Function(_RatingSelected value)? ratingSelected,
    TResult? Function(_FiltersOpened value)? filtersOpened,
    TResult? Function(_FiltersClosed value)? filtersClosed,
    TResult? Function(_FiltersReset value)? filtersReset,
  }) {
    return distanceSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult Function(_DistanceSelected value)? distanceSelected,
    TResult Function(_RatingSelected value)? ratingSelected,
    TResult Function(_FiltersOpened value)? filtersOpened,
    TResult Function(_FiltersClosed value)? filtersClosed,
    TResult Function(_FiltersReset value)? filtersReset,
    required TResult orElse(),
  }) {
    if (distanceSelected != null) {
      return distanceSelected(this);
    }
    return orElse();
  }
}

abstract class _DistanceSelected implements DonorsEvent {
  const factory _DistanceSelected(final String value) = _$DistanceSelectedImpl;

  String get value;

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DistanceSelectedImplCopyWith<_$DistanceSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RatingSelectedImplCopyWith<$Res> {
  factory _$$RatingSelectedImplCopyWith(
    _$RatingSelectedImpl value,
    $Res Function(_$RatingSelectedImpl) then,
  ) = __$$RatingSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double value});
}

/// @nodoc
class __$$RatingSelectedImplCopyWithImpl<$Res>
    extends _$DonorsEventCopyWithImpl<$Res, _$RatingSelectedImpl>
    implements _$$RatingSelectedImplCopyWith<$Res> {
  __$$RatingSelectedImplCopyWithImpl(
    _$RatingSelectedImpl _value,
    $Res Function(_$RatingSelectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$RatingSelectedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$RatingSelectedImpl implements _RatingSelected {
  const _$RatingSelectedImpl(this.value);

  @override
  final double value;

  @override
  String toString() {
    return 'DonorsEvent.ratingSelected(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingSelectedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingSelectedImplCopyWith<_$RatingSelectedImpl> get copyWith =>
      __$$RatingSelectedImplCopyWithImpl<_$RatingSelectedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) searchChanged,
    required TResult Function(String value) bloodGroupSelected,
    required TResult Function(String value) distanceSelected,
    required TResult Function(double value) ratingSelected,
    required TResult Function() filtersOpened,
    required TResult Function() filtersClosed,
    required TResult Function() filtersReset,
  }) {
    return ratingSelected(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? searchChanged,
    TResult? Function(String value)? bloodGroupSelected,
    TResult? Function(String value)? distanceSelected,
    TResult? Function(double value)? ratingSelected,
    TResult? Function()? filtersOpened,
    TResult? Function()? filtersClosed,
    TResult? Function()? filtersReset,
  }) {
    return ratingSelected?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? searchChanged,
    TResult Function(String value)? bloodGroupSelected,
    TResult Function(String value)? distanceSelected,
    TResult Function(double value)? ratingSelected,
    TResult Function()? filtersOpened,
    TResult Function()? filtersClosed,
    TResult Function()? filtersReset,
    required TResult orElse(),
  }) {
    if (ratingSelected != null) {
      return ratingSelected(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_BloodGroupSelected value) bloodGroupSelected,
    required TResult Function(_DistanceSelected value) distanceSelected,
    required TResult Function(_RatingSelected value) ratingSelected,
    required TResult Function(_FiltersOpened value) filtersOpened,
    required TResult Function(_FiltersClosed value) filtersClosed,
    required TResult Function(_FiltersReset value) filtersReset,
  }) {
    return ratingSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult? Function(_DistanceSelected value)? distanceSelected,
    TResult? Function(_RatingSelected value)? ratingSelected,
    TResult? Function(_FiltersOpened value)? filtersOpened,
    TResult? Function(_FiltersClosed value)? filtersClosed,
    TResult? Function(_FiltersReset value)? filtersReset,
  }) {
    return ratingSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult Function(_DistanceSelected value)? distanceSelected,
    TResult Function(_RatingSelected value)? ratingSelected,
    TResult Function(_FiltersOpened value)? filtersOpened,
    TResult Function(_FiltersClosed value)? filtersClosed,
    TResult Function(_FiltersReset value)? filtersReset,
    required TResult orElse(),
  }) {
    if (ratingSelected != null) {
      return ratingSelected(this);
    }
    return orElse();
  }
}

abstract class _RatingSelected implements DonorsEvent {
  const factory _RatingSelected(final double value) = _$RatingSelectedImpl;

  double get value;

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingSelectedImplCopyWith<_$RatingSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FiltersOpenedImplCopyWith<$Res> {
  factory _$$FiltersOpenedImplCopyWith(
    _$FiltersOpenedImpl value,
    $Res Function(_$FiltersOpenedImpl) then,
  ) = __$$FiltersOpenedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FiltersOpenedImplCopyWithImpl<$Res>
    extends _$DonorsEventCopyWithImpl<$Res, _$FiltersOpenedImpl>
    implements _$$FiltersOpenedImplCopyWith<$Res> {
  __$$FiltersOpenedImplCopyWithImpl(
    _$FiltersOpenedImpl _value,
    $Res Function(_$FiltersOpenedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FiltersOpenedImpl implements _FiltersOpened {
  const _$FiltersOpenedImpl();

  @override
  String toString() {
    return 'DonorsEvent.filtersOpened()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FiltersOpenedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) searchChanged,
    required TResult Function(String value) bloodGroupSelected,
    required TResult Function(String value) distanceSelected,
    required TResult Function(double value) ratingSelected,
    required TResult Function() filtersOpened,
    required TResult Function() filtersClosed,
    required TResult Function() filtersReset,
  }) {
    return filtersOpened();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? searchChanged,
    TResult? Function(String value)? bloodGroupSelected,
    TResult? Function(String value)? distanceSelected,
    TResult? Function(double value)? ratingSelected,
    TResult? Function()? filtersOpened,
    TResult? Function()? filtersClosed,
    TResult? Function()? filtersReset,
  }) {
    return filtersOpened?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? searchChanged,
    TResult Function(String value)? bloodGroupSelected,
    TResult Function(String value)? distanceSelected,
    TResult Function(double value)? ratingSelected,
    TResult Function()? filtersOpened,
    TResult Function()? filtersClosed,
    TResult Function()? filtersReset,
    required TResult orElse(),
  }) {
    if (filtersOpened != null) {
      return filtersOpened();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_BloodGroupSelected value) bloodGroupSelected,
    required TResult Function(_DistanceSelected value) distanceSelected,
    required TResult Function(_RatingSelected value) ratingSelected,
    required TResult Function(_FiltersOpened value) filtersOpened,
    required TResult Function(_FiltersClosed value) filtersClosed,
    required TResult Function(_FiltersReset value) filtersReset,
  }) {
    return filtersOpened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult? Function(_DistanceSelected value)? distanceSelected,
    TResult? Function(_RatingSelected value)? ratingSelected,
    TResult? Function(_FiltersOpened value)? filtersOpened,
    TResult? Function(_FiltersClosed value)? filtersClosed,
    TResult? Function(_FiltersReset value)? filtersReset,
  }) {
    return filtersOpened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult Function(_DistanceSelected value)? distanceSelected,
    TResult Function(_RatingSelected value)? ratingSelected,
    TResult Function(_FiltersOpened value)? filtersOpened,
    TResult Function(_FiltersClosed value)? filtersClosed,
    TResult Function(_FiltersReset value)? filtersReset,
    required TResult orElse(),
  }) {
    if (filtersOpened != null) {
      return filtersOpened(this);
    }
    return orElse();
  }
}

abstract class _FiltersOpened implements DonorsEvent {
  const factory _FiltersOpened() = _$FiltersOpenedImpl;
}

/// @nodoc
abstract class _$$FiltersClosedImplCopyWith<$Res> {
  factory _$$FiltersClosedImplCopyWith(
    _$FiltersClosedImpl value,
    $Res Function(_$FiltersClosedImpl) then,
  ) = __$$FiltersClosedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FiltersClosedImplCopyWithImpl<$Res>
    extends _$DonorsEventCopyWithImpl<$Res, _$FiltersClosedImpl>
    implements _$$FiltersClosedImplCopyWith<$Res> {
  __$$FiltersClosedImplCopyWithImpl(
    _$FiltersClosedImpl _value,
    $Res Function(_$FiltersClosedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FiltersClosedImpl implements _FiltersClosed {
  const _$FiltersClosedImpl();

  @override
  String toString() {
    return 'DonorsEvent.filtersClosed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FiltersClosedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) searchChanged,
    required TResult Function(String value) bloodGroupSelected,
    required TResult Function(String value) distanceSelected,
    required TResult Function(double value) ratingSelected,
    required TResult Function() filtersOpened,
    required TResult Function() filtersClosed,
    required TResult Function() filtersReset,
  }) {
    return filtersClosed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? searchChanged,
    TResult? Function(String value)? bloodGroupSelected,
    TResult? Function(String value)? distanceSelected,
    TResult? Function(double value)? ratingSelected,
    TResult? Function()? filtersOpened,
    TResult? Function()? filtersClosed,
    TResult? Function()? filtersReset,
  }) {
    return filtersClosed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? searchChanged,
    TResult Function(String value)? bloodGroupSelected,
    TResult Function(String value)? distanceSelected,
    TResult Function(double value)? ratingSelected,
    TResult Function()? filtersOpened,
    TResult Function()? filtersClosed,
    TResult Function()? filtersReset,
    required TResult orElse(),
  }) {
    if (filtersClosed != null) {
      return filtersClosed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_BloodGroupSelected value) bloodGroupSelected,
    required TResult Function(_DistanceSelected value) distanceSelected,
    required TResult Function(_RatingSelected value) ratingSelected,
    required TResult Function(_FiltersOpened value) filtersOpened,
    required TResult Function(_FiltersClosed value) filtersClosed,
    required TResult Function(_FiltersReset value) filtersReset,
  }) {
    return filtersClosed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult? Function(_DistanceSelected value)? distanceSelected,
    TResult? Function(_RatingSelected value)? ratingSelected,
    TResult? Function(_FiltersOpened value)? filtersOpened,
    TResult? Function(_FiltersClosed value)? filtersClosed,
    TResult? Function(_FiltersReset value)? filtersReset,
  }) {
    return filtersClosed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult Function(_DistanceSelected value)? distanceSelected,
    TResult Function(_RatingSelected value)? ratingSelected,
    TResult Function(_FiltersOpened value)? filtersOpened,
    TResult Function(_FiltersClosed value)? filtersClosed,
    TResult Function(_FiltersReset value)? filtersReset,
    required TResult orElse(),
  }) {
    if (filtersClosed != null) {
      return filtersClosed(this);
    }
    return orElse();
  }
}

abstract class _FiltersClosed implements DonorsEvent {
  const factory _FiltersClosed() = _$FiltersClosedImpl;
}

/// @nodoc
abstract class _$$FiltersResetImplCopyWith<$Res> {
  factory _$$FiltersResetImplCopyWith(
    _$FiltersResetImpl value,
    $Res Function(_$FiltersResetImpl) then,
  ) = __$$FiltersResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FiltersResetImplCopyWithImpl<$Res>
    extends _$DonorsEventCopyWithImpl<$Res, _$FiltersResetImpl>
    implements _$$FiltersResetImplCopyWith<$Res> {
  __$$FiltersResetImplCopyWithImpl(
    _$FiltersResetImpl _value,
    $Res Function(_$FiltersResetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DonorsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FiltersResetImpl implements _FiltersReset {
  const _$FiltersResetImpl();

  @override
  String toString() {
    return 'DonorsEvent.filtersReset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FiltersResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) searchChanged,
    required TResult Function(String value) bloodGroupSelected,
    required TResult Function(String value) distanceSelected,
    required TResult Function(double value) ratingSelected,
    required TResult Function() filtersOpened,
    required TResult Function() filtersClosed,
    required TResult Function() filtersReset,
  }) {
    return filtersReset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? searchChanged,
    TResult? Function(String value)? bloodGroupSelected,
    TResult? Function(String value)? distanceSelected,
    TResult? Function(double value)? ratingSelected,
    TResult? Function()? filtersOpened,
    TResult? Function()? filtersClosed,
    TResult? Function()? filtersReset,
  }) {
    return filtersReset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? searchChanged,
    TResult Function(String value)? bloodGroupSelected,
    TResult Function(String value)? distanceSelected,
    TResult Function(double value)? ratingSelected,
    TResult Function()? filtersOpened,
    TResult Function()? filtersClosed,
    TResult Function()? filtersReset,
    required TResult orElse(),
  }) {
    if (filtersReset != null) {
      return filtersReset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_BloodGroupSelected value) bloodGroupSelected,
    required TResult Function(_DistanceSelected value) distanceSelected,
    required TResult Function(_RatingSelected value) ratingSelected,
    required TResult Function(_FiltersOpened value) filtersOpened,
    required TResult Function(_FiltersClosed value) filtersClosed,
    required TResult Function(_FiltersReset value) filtersReset,
  }) {
    return filtersReset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult? Function(_DistanceSelected value)? distanceSelected,
    TResult? Function(_RatingSelected value)? ratingSelected,
    TResult? Function(_FiltersOpened value)? filtersOpened,
    TResult? Function(_FiltersClosed value)? filtersClosed,
    TResult? Function(_FiltersReset value)? filtersReset,
  }) {
    return filtersReset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_BloodGroupSelected value)? bloodGroupSelected,
    TResult Function(_DistanceSelected value)? distanceSelected,
    TResult Function(_RatingSelected value)? ratingSelected,
    TResult Function(_FiltersOpened value)? filtersOpened,
    TResult Function(_FiltersClosed value)? filtersClosed,
    TResult Function(_FiltersReset value)? filtersReset,
    required TResult orElse(),
  }) {
    if (filtersReset != null) {
      return filtersReset(this);
    }
    return orElse();
  }
}

abstract class _FiltersReset implements DonorsEvent {
  const factory _FiltersReset() = _$FiltersResetImpl;
}
