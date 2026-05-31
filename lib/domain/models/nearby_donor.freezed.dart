// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearby_donor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NearbyDonor {
  DonorLocationModel get donor => throw _privateConstructorUsedError;
  double get distanceKm => throw _privateConstructorUsedError;

  /// Create a copy of NearbyDonor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NearbyDonorCopyWith<NearbyDonor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearbyDonorCopyWith<$Res> {
  factory $NearbyDonorCopyWith(
    NearbyDonor value,
    $Res Function(NearbyDonor) then,
  ) = _$NearbyDonorCopyWithImpl<$Res, NearbyDonor>;
  @useResult
  $Res call({DonorLocationModel donor, double distanceKm});

  $DonorLocationModelCopyWith<$Res> get donor;
}

/// @nodoc
class _$NearbyDonorCopyWithImpl<$Res, $Val extends NearbyDonor>
    implements $NearbyDonorCopyWith<$Res> {
  _$NearbyDonorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NearbyDonor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? donor = null, Object? distanceKm = null}) {
    return _then(
      _value.copyWith(
            donor: null == donor
                ? _value.donor
                : donor // ignore: cast_nullable_to_non_nullable
                      as DonorLocationModel,
            distanceKm: null == distanceKm
                ? _value.distanceKm
                : distanceKm // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }

  /// Create a copy of NearbyDonor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DonorLocationModelCopyWith<$Res> get donor {
    return $DonorLocationModelCopyWith<$Res>(_value.donor, (value) {
      return _then(_value.copyWith(donor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NearbyDonorImplCopyWith<$Res>
    implements $NearbyDonorCopyWith<$Res> {
  factory _$$NearbyDonorImplCopyWith(
    _$NearbyDonorImpl value,
    $Res Function(_$NearbyDonorImpl) then,
  ) = __$$NearbyDonorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DonorLocationModel donor, double distanceKm});

  @override
  $DonorLocationModelCopyWith<$Res> get donor;
}

/// @nodoc
class __$$NearbyDonorImplCopyWithImpl<$Res>
    extends _$NearbyDonorCopyWithImpl<$Res, _$NearbyDonorImpl>
    implements _$$NearbyDonorImplCopyWith<$Res> {
  __$$NearbyDonorImplCopyWithImpl(
    _$NearbyDonorImpl _value,
    $Res Function(_$NearbyDonorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NearbyDonor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? donor = null, Object? distanceKm = null}) {
    return _then(
      _$NearbyDonorImpl(
        donor: null == donor
            ? _value.donor
            : donor // ignore: cast_nullable_to_non_nullable
                  as DonorLocationModel,
        distanceKm: null == distanceKm
            ? _value.distanceKm
            : distanceKm // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$NearbyDonorImpl extends _NearbyDonor {
  const _$NearbyDonorImpl({required this.donor, required this.distanceKm})
    : super._();

  @override
  final DonorLocationModel donor;
  @override
  final double distanceKm;

  @override
  String toString() {
    return 'NearbyDonor(donor: $donor, distanceKm: $distanceKm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NearbyDonorImpl &&
            (identical(other.donor, donor) || other.donor == donor) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm));
  }

  @override
  int get hashCode => Object.hash(runtimeType, donor, distanceKm);

  /// Create a copy of NearbyDonor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NearbyDonorImplCopyWith<_$NearbyDonorImpl> get copyWith =>
      __$$NearbyDonorImplCopyWithImpl<_$NearbyDonorImpl>(this, _$identity);
}

abstract class _NearbyDonor extends NearbyDonor {
  const factory _NearbyDonor({
    required final DonorLocationModel donor,
    required final double distanceKm,
  }) = _$NearbyDonorImpl;
  const _NearbyDonor._() : super._();

  @override
  DonorLocationModel get donor;
  @override
  double get distanceKm;

  /// Create a copy of NearbyDonor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NearbyDonorImplCopyWith<_$NearbyDonorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
