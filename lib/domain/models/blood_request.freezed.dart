// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blood_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BloodRequest {
  String get uid => throw _privateConstructorUsedError;
  String get patientName => throw _privateConstructorUsedError;
  String get bloodGroup => throw _privateConstructorUsedError;
  int get units => throw _privateConstructorUsedError;
  String get hospital => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get urgency => throw _privateConstructorUsedError;
  DateTime get needBy => throw _privateConstructorUsedError;
  String get contact => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  RequestStatus get status => throw _privateConstructorUsedError;
  CloseReason? get closeReason => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of BloodRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BloodRequestCopyWith<BloodRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BloodRequestCopyWith<$Res> {
  factory $BloodRequestCopyWith(
    BloodRequest value,
    $Res Function(BloodRequest) then,
  ) = _$BloodRequestCopyWithImpl<$Res, BloodRequest>;
  @useResult
  $Res call({
    String uid,
    String patientName,
    String bloodGroup,
    int units,
    String hospital,
    String address,
    String urgency,
    DateTime needBy,
    String contact,
    String notes,
    double? latitude,
    double? longitude,
    RequestStatus status,
    CloseReason? closeReason,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$BloodRequestCopyWithImpl<$Res, $Val extends BloodRequest>
    implements $BloodRequestCopyWith<$Res> {
  _$BloodRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BloodRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? patientName = null,
    Object? bloodGroup = null,
    Object? units = null,
    Object? hospital = null,
    Object? address = null,
    Object? urgency = null,
    Object? needBy = null,
    Object? contact = null,
    Object? notes = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? status = null,
    Object? closeReason = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
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
            needBy: null == needBy
                ? _value.needBy
                : needBy // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            contact: null == contact
                ? _value.contact
                : contact // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
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
                      as RequestStatus,
            closeReason: freezed == closeReason
                ? _value.closeReason
                : closeReason // ignore: cast_nullable_to_non_nullable
                      as CloseReason?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BloodRequestImplCopyWith<$Res>
    implements $BloodRequestCopyWith<$Res> {
  factory _$$BloodRequestImplCopyWith(
    _$BloodRequestImpl value,
    $Res Function(_$BloodRequestImpl) then,
  ) = __$$BloodRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uid,
    String patientName,
    String bloodGroup,
    int units,
    String hospital,
    String address,
    String urgency,
    DateTime needBy,
    String contact,
    String notes,
    double? latitude,
    double? longitude,
    RequestStatus status,
    CloseReason? closeReason,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$BloodRequestImplCopyWithImpl<$Res>
    extends _$BloodRequestCopyWithImpl<$Res, _$BloodRequestImpl>
    implements _$$BloodRequestImplCopyWith<$Res> {
  __$$BloodRequestImplCopyWithImpl(
    _$BloodRequestImpl _value,
    $Res Function(_$BloodRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BloodRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? patientName = null,
    Object? bloodGroup = null,
    Object? units = null,
    Object? hospital = null,
    Object? address = null,
    Object? urgency = null,
    Object? needBy = null,
    Object? contact = null,
    Object? notes = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? status = null,
    Object? closeReason = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$BloodRequestImpl(
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
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
        needBy: null == needBy
            ? _value.needBy
            : needBy // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        contact: null == contact
            ? _value.contact
            : contact // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
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
                  as RequestStatus,
        closeReason: freezed == closeReason
            ? _value.closeReason
            : closeReason // ignore: cast_nullable_to_non_nullable
                  as CloseReason?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$BloodRequestImpl implements _BloodRequest {
  const _$BloodRequestImpl({
    required this.uid,
    required this.patientName,
    required this.bloodGroup,
    required this.units,
    required this.hospital,
    required this.address,
    required this.urgency,
    required this.needBy,
    required this.contact,
    required this.notes,
    this.latitude,
    this.longitude,
    required this.status,
    this.closeReason,
    this.createdAt,
  });

  @override
  final String uid;
  @override
  final String patientName;
  @override
  final String bloodGroup;
  @override
  final int units;
  @override
  final String hospital;
  @override
  final String address;
  @override
  final String urgency;
  @override
  final DateTime needBy;
  @override
  final String contact;
  @override
  final String notes;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final RequestStatus status;
  @override
  final CloseReason? closeReason;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'BloodRequest(uid: $uid, patientName: $patientName, bloodGroup: $bloodGroup, units: $units, hospital: $hospital, address: $address, urgency: $urgency, needBy: $needBy, contact: $contact, notes: $notes, latitude: $latitude, longitude: $longitude, status: $status, closeReason: $closeReason, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BloodRequestImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
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
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.closeReason, closeReason) ||
                other.closeReason == closeReason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    uid,
    patientName,
    bloodGroup,
    units,
    hospital,
    address,
    urgency,
    needBy,
    contact,
    notes,
    latitude,
    longitude,
    status,
    closeReason,
    createdAt,
  );

  /// Create a copy of BloodRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BloodRequestImplCopyWith<_$BloodRequestImpl> get copyWith =>
      __$$BloodRequestImplCopyWithImpl<_$BloodRequestImpl>(this, _$identity);
}

abstract class _BloodRequest implements BloodRequest {
  const factory _BloodRequest({
    required final String uid,
    required final String patientName,
    required final String bloodGroup,
    required final int units,
    required final String hospital,
    required final String address,
    required final String urgency,
    required final DateTime needBy,
    required final String contact,
    required final String notes,
    final double? latitude,
    final double? longitude,
    required final RequestStatus status,
    final CloseReason? closeReason,
    final DateTime? createdAt,
  }) = _$BloodRequestImpl;

  @override
  String get uid;
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
  DateTime get needBy;
  @override
  String get contact;
  @override
  String get notes;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  RequestStatus get status;
  @override
  CloseReason? get closeReason;
  @override
  DateTime? get createdAt;

  /// Create a copy of BloodRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BloodRequestImplCopyWith<_$BloodRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
