// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CreateRequestState {
  String get patientName => throw _privateConstructorUsedError;
  String get bloodGroup => throw _privateConstructorUsedError;
  int get units => throw _privateConstructorUsedError;
  String get hospital => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get urgency => throw _privateConstructorUsedError;
  DateTime? get needBy => throw _privateConstructorUsedError;
  String get contact => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  bool get confirmed1 => throw _privateConstructorUsedError;
  bool get confirmed2 => throw _privateConstructorUsedError;
  bool get isGpsLoading => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  CreateRequestStatus get status => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CreateRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateRequestStateCopyWith<CreateRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateRequestStateCopyWith<$Res> {
  factory $CreateRequestStateCopyWith(
    CreateRequestState value,
    $Res Function(CreateRequestState) then,
  ) = _$CreateRequestStateCopyWithImpl<$Res, CreateRequestState>;
  @useResult
  $Res call({
    String patientName,
    String bloodGroup,
    int units,
    String hospital,
    String address,
    String urgency,
    DateTime? needBy,
    String contact,
    String notes,
    bool confirmed1,
    bool confirmed2,
    bool isGpsLoading,
    double? latitude,
    double? longitude,
    CreateRequestStatus status,
    String errorMessage,
  });
}

/// @nodoc
class _$CreateRequestStateCopyWithImpl<$Res, $Val extends CreateRequestState>
    implements $CreateRequestStateCopyWith<$Res> {
  _$CreateRequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateRequestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientName = null,
    Object? bloodGroup = null,
    Object? units = null,
    Object? hospital = null,
    Object? address = null,
    Object? urgency = null,
    Object? needBy = freezed,
    Object? contact = null,
    Object? notes = null,
    Object? confirmed1 = null,
    Object? confirmed2 = null,
    Object? isGpsLoading = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? status = null,
    Object? errorMessage = null,
  }) {
    return _then(
      _value.copyWith(
            patientName: null == patientName
                ? _value.patientName
                : patientName // ignore: cast_nullable_to_non_nullable
                      as String,
            bloodGroup: null == bloodGroup
                ? _value.bloodGroup
                : bloodGroup // ignore: cast_nullable_to_non_nullable
                      as String,
            units: null == units
                ? _value.units
                : units // ignore: cast_nullable_to_non_nullable
                      as int,
            hospital: null == hospital
                ? _value.hospital
                : hospital // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            urgency: null == urgency
                ? _value.urgency
                : urgency // ignore: cast_nullable_to_non_nullable
                      as String,
            needBy: freezed == needBy
                ? _value.needBy
                : needBy // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            contact: null == contact
                ? _value.contact
                : contact // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
            confirmed1: null == confirmed1
                ? _value.confirmed1
                : confirmed1 // ignore: cast_nullable_to_non_nullable
                      as bool,
            confirmed2: null == confirmed2
                ? _value.confirmed2
                : confirmed2 // ignore: cast_nullable_to_non_nullable
                      as bool,
            isGpsLoading: null == isGpsLoading
                ? _value.isGpsLoading
                : isGpsLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CreateRequestStatus,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateRequestStateImplCopyWith<$Res>
    implements $CreateRequestStateCopyWith<$Res> {
  factory _$$CreateRequestStateImplCopyWith(
    _$CreateRequestStateImpl value,
    $Res Function(_$CreateRequestStateImpl) then,
  ) = __$$CreateRequestStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String patientName,
    String bloodGroup,
    int units,
    String hospital,
    String address,
    String urgency,
    DateTime? needBy,
    String contact,
    String notes,
    bool confirmed1,
    bool confirmed2,
    bool isGpsLoading,
    double? latitude,
    double? longitude,
    CreateRequestStatus status,
    String errorMessage,
  });
}

/// @nodoc
class __$$CreateRequestStateImplCopyWithImpl<$Res>
    extends _$CreateRequestStateCopyWithImpl<$Res, _$CreateRequestStateImpl>
    implements _$$CreateRequestStateImplCopyWith<$Res> {
  __$$CreateRequestStateImplCopyWithImpl(
    _$CreateRequestStateImpl _value,
    $Res Function(_$CreateRequestStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateRequestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientName = null,
    Object? bloodGroup = null,
    Object? units = null,
    Object? hospital = null,
    Object? address = null,
    Object? urgency = null,
    Object? needBy = freezed,
    Object? contact = null,
    Object? notes = null,
    Object? confirmed1 = null,
    Object? confirmed2 = null,
    Object? isGpsLoading = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? status = null,
    Object? errorMessage = null,
  }) {
    return _then(
      _$CreateRequestStateImpl(
        patientName: null == patientName
            ? _value.patientName
            : patientName // ignore: cast_nullable_to_non_nullable
                  as String,
        bloodGroup: null == bloodGroup
            ? _value.bloodGroup
            : bloodGroup // ignore: cast_nullable_to_non_nullable
                  as String,
        units: null == units
            ? _value.units
            : units // ignore: cast_nullable_to_non_nullable
                  as int,
        hospital: null == hospital
            ? _value.hospital
            : hospital // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        urgency: null == urgency
            ? _value.urgency
            : urgency // ignore: cast_nullable_to_non_nullable
                  as String,
        needBy: freezed == needBy
            ? _value.needBy
            : needBy // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        contact: null == contact
            ? _value.contact
            : contact // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
        confirmed1: null == confirmed1
            ? _value.confirmed1
            : confirmed1 // ignore: cast_nullable_to_non_nullable
                  as bool,
        confirmed2: null == confirmed2
            ? _value.confirmed2
            : confirmed2 // ignore: cast_nullable_to_non_nullable
                  as bool,
        isGpsLoading: null == isGpsLoading
            ? _value.isGpsLoading
            : isGpsLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CreateRequestStatus,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CreateRequestStateImpl implements _CreateRequestState {
  const _$CreateRequestStateImpl({
    this.patientName = '',
    this.bloodGroup = '',
    this.units = 1,
    this.hospital = '',
    this.address = '',
    this.urgency = 'URGENT',
    this.needBy,
    this.contact = '',
    this.notes = '',
    this.confirmed1 = false,
    this.confirmed2 = false,
    this.isGpsLoading = false,
    this.latitude,
    this.longitude,
    this.status = CreateRequestStatus.initial,
    this.errorMessage = '',
  });

  @override
  @JsonKey()
  final String patientName;
  @override
  @JsonKey()
  final String bloodGroup;
  @override
  @JsonKey()
  final int units;
  @override
  @JsonKey()
  final String hospital;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String urgency;
  @override
  final DateTime? needBy;
  @override
  @JsonKey()
  final String contact;
  @override
  @JsonKey()
  final String notes;
  @override
  @JsonKey()
  final bool confirmed1;
  @override
  @JsonKey()
  final bool confirmed2;
  @override
  @JsonKey()
  final bool isGpsLoading;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey()
  final CreateRequestStatus status;
  @override
  @JsonKey()
  final String errorMessage;

  @override
  String toString() {
    return 'CreateRequestState(patientName: $patientName, bloodGroup: $bloodGroup, units: $units, hospital: $hospital, address: $address, urgency: $urgency, needBy: $needBy, contact: $contact, notes: $notes, confirmed1: $confirmed1, confirmed2: $confirmed2, isGpsLoading: $isGpsLoading, latitude: $latitude, longitude: $longitude, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateRequestStateImpl &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.units, units) || other.units == units) &&
            (identical(other.hospital, hospital) ||
                other.hospital == hospital) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.urgency, urgency) || other.urgency == urgency) &&
            (identical(other.needBy, needBy) || other.needBy == needBy) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.confirmed1, confirmed1) ||
                other.confirmed1 == confirmed1) &&
            (identical(other.confirmed2, confirmed2) ||
                other.confirmed2 == confirmed2) &&
            (identical(other.isGpsLoading, isGpsLoading) ||
                other.isGpsLoading == isGpsLoading) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    patientName,
    bloodGroup,
    units,
    hospital,
    address,
    urgency,
    needBy,
    contact,
    notes,
    confirmed1,
    confirmed2,
    isGpsLoading,
    latitude,
    longitude,
    status,
    errorMessage,
  );

  /// Create a copy of CreateRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateRequestStateImplCopyWith<_$CreateRequestStateImpl> get copyWith =>
      __$$CreateRequestStateImplCopyWithImpl<_$CreateRequestStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CreateRequestState implements CreateRequestState {
  const factory _CreateRequestState({
    final String patientName,
    final String bloodGroup,
    final int units,
    final String hospital,
    final String address,
    final String urgency,
    final DateTime? needBy,
    final String contact,
    final String notes,
    final bool confirmed1,
    final bool confirmed2,
    final bool isGpsLoading,
    final double? latitude,
    final double? longitude,
    final CreateRequestStatus status,
    final String errorMessage,
  }) = _$CreateRequestStateImpl;

  @override
  String get patientName;
  @override
  String get bloodGroup;
  @override
  int get units;
  @override
  String get hospital;
  @override
  String get address;
  @override
  String get urgency;
  @override
  DateTime? get needBy;
  @override
  String get contact;
  @override
  String get notes;
  @override
  bool get confirmed1;
  @override
  bool get confirmed2;
  @override
  bool get isGpsLoading;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  CreateRequestStatus get status;
  @override
  String get errorMessage;

  /// Create a copy of CreateRequestState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateRequestStateImplCopyWith<_$CreateRequestStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
