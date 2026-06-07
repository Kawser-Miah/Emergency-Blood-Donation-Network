// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_requests_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MyRequestsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshed,
    required TResult Function(String requestId) interestedDonorsRequested,
    required TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )
    requestUpdated,
    required TResult Function(String id) requestFulfilled,
    required TResult Function(String id) requestDeleted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshed,
    TResult? Function(String requestId)? interestedDonorsRequested,
    TResult? Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult? Function(String id)? requestFulfilled,
    TResult? Function(String id)? requestDeleted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshed,
    TResult Function(String requestId)? interestedDonorsRequested,
    TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult Function(String id)? requestFulfilled,
    TResult Function(String id)? requestDeleted,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Refreshed value) refreshed,
    required TResult Function(_InterestedDonorsRequested value)
    interestedDonorsRequested,
    required TResult Function(_RequestUpdated value) requestUpdated,
    required TResult Function(_RequestFulfilled value) requestFulfilled,
    required TResult Function(_RequestDeleted value) requestDeleted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Refreshed value)? refreshed,
    TResult? Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult? Function(_RequestUpdated value)? requestUpdated,
    TResult? Function(_RequestFulfilled value)? requestFulfilled,
    TResult? Function(_RequestDeleted value)? requestDeleted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Refreshed value)? refreshed,
    TResult Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult Function(_RequestUpdated value)? requestUpdated,
    TResult Function(_RequestFulfilled value)? requestFulfilled,
    TResult Function(_RequestDeleted value)? requestDeleted,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyRequestsEventCopyWith<$Res> {
  factory $MyRequestsEventCopyWith(
    MyRequestsEvent value,
    $Res Function(MyRequestsEvent) then,
  ) = _$MyRequestsEventCopyWithImpl<$Res, MyRequestsEvent>;
}

/// @nodoc
class _$MyRequestsEventCopyWithImpl<$Res, $Val extends MyRequestsEvent>
    implements $MyRequestsEventCopyWith<$Res> {
  _$MyRequestsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyRequestsEvent
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
    extends _$MyRequestsEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
    _$StartedImpl _value,
    $Res Function(_$StartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'MyRequestsEvent.started()';
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
    required TResult Function() refreshed,
    required TResult Function(String requestId) interestedDonorsRequested,
    required TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )
    requestUpdated,
    required TResult Function(String id) requestFulfilled,
    required TResult Function(String id) requestDeleted,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshed,
    TResult? Function(String requestId)? interestedDonorsRequested,
    TResult? Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult? Function(String id)? requestFulfilled,
    TResult? Function(String id)? requestDeleted,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshed,
    TResult Function(String requestId)? interestedDonorsRequested,
    TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult Function(String id)? requestFulfilled,
    TResult Function(String id)? requestDeleted,
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
    required TResult Function(_Refreshed value) refreshed,
    required TResult Function(_InterestedDonorsRequested value)
    interestedDonorsRequested,
    required TResult Function(_RequestUpdated value) requestUpdated,
    required TResult Function(_RequestFulfilled value) requestFulfilled,
    required TResult Function(_RequestDeleted value) requestDeleted,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Refreshed value)? refreshed,
    TResult? Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult? Function(_RequestUpdated value)? requestUpdated,
    TResult? Function(_RequestFulfilled value)? requestFulfilled,
    TResult? Function(_RequestDeleted value)? requestDeleted,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Refreshed value)? refreshed,
    TResult Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult Function(_RequestUpdated value)? requestUpdated,
    TResult Function(_RequestFulfilled value)? requestFulfilled,
    TResult Function(_RequestDeleted value)? requestDeleted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements MyRequestsEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$RefreshedImplCopyWith<$Res> {
  factory _$$RefreshedImplCopyWith(
    _$RefreshedImpl value,
    $Res Function(_$RefreshedImpl) then,
  ) = __$$RefreshedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshedImplCopyWithImpl<$Res>
    extends _$MyRequestsEventCopyWithImpl<$Res, _$RefreshedImpl>
    implements _$$RefreshedImplCopyWith<$Res> {
  __$$RefreshedImplCopyWithImpl(
    _$RefreshedImpl _value,
    $Res Function(_$RefreshedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshedImpl implements _Refreshed {
  const _$RefreshedImpl();

  @override
  String toString() {
    return 'MyRequestsEvent.refreshed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshed,
    required TResult Function(String requestId) interestedDonorsRequested,
    required TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )
    requestUpdated,
    required TResult Function(String id) requestFulfilled,
    required TResult Function(String id) requestDeleted,
  }) {
    return refreshed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshed,
    TResult? Function(String requestId)? interestedDonorsRequested,
    TResult? Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult? Function(String id)? requestFulfilled,
    TResult? Function(String id)? requestDeleted,
  }) {
    return refreshed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshed,
    TResult Function(String requestId)? interestedDonorsRequested,
    TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult Function(String id)? requestFulfilled,
    TResult Function(String id)? requestDeleted,
    required TResult orElse(),
  }) {
    if (refreshed != null) {
      return refreshed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Refreshed value) refreshed,
    required TResult Function(_InterestedDonorsRequested value)
    interestedDonorsRequested,
    required TResult Function(_RequestUpdated value) requestUpdated,
    required TResult Function(_RequestFulfilled value) requestFulfilled,
    required TResult Function(_RequestDeleted value) requestDeleted,
  }) {
    return refreshed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Refreshed value)? refreshed,
    TResult? Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult? Function(_RequestUpdated value)? requestUpdated,
    TResult? Function(_RequestFulfilled value)? requestFulfilled,
    TResult? Function(_RequestDeleted value)? requestDeleted,
  }) {
    return refreshed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Refreshed value)? refreshed,
    TResult Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult Function(_RequestUpdated value)? requestUpdated,
    TResult Function(_RequestFulfilled value)? requestFulfilled,
    TResult Function(_RequestDeleted value)? requestDeleted,
    required TResult orElse(),
  }) {
    if (refreshed != null) {
      return refreshed(this);
    }
    return orElse();
  }
}

abstract class _Refreshed implements MyRequestsEvent {
  const factory _Refreshed() = _$RefreshedImpl;
}

/// @nodoc
abstract class _$$InterestedDonorsRequestedImplCopyWith<$Res> {
  factory _$$InterestedDonorsRequestedImplCopyWith(
    _$InterestedDonorsRequestedImpl value,
    $Res Function(_$InterestedDonorsRequestedImpl) then,
  ) = __$$InterestedDonorsRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String requestId});
}

/// @nodoc
class __$$InterestedDonorsRequestedImplCopyWithImpl<$Res>
    extends _$MyRequestsEventCopyWithImpl<$Res, _$InterestedDonorsRequestedImpl>
    implements _$$InterestedDonorsRequestedImplCopyWith<$Res> {
  __$$InterestedDonorsRequestedImplCopyWithImpl(
    _$InterestedDonorsRequestedImpl _value,
    $Res Function(_$InterestedDonorsRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? requestId = null}) {
    return _then(
      _$InterestedDonorsRequestedImpl(
        null == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$InterestedDonorsRequestedImpl implements _InterestedDonorsRequested {
  const _$InterestedDonorsRequestedImpl(this.requestId);

  @override
  final String requestId;

  @override
  String toString() {
    return 'MyRequestsEvent.interestedDonorsRequested(requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterestedDonorsRequestedImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, requestId);

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterestedDonorsRequestedImplCopyWith<_$InterestedDonorsRequestedImpl>
  get copyWith =>
      __$$InterestedDonorsRequestedImplCopyWithImpl<
        _$InterestedDonorsRequestedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshed,
    required TResult Function(String requestId) interestedDonorsRequested,
    required TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )
    requestUpdated,
    required TResult Function(String id) requestFulfilled,
    required TResult Function(String id) requestDeleted,
  }) {
    return interestedDonorsRequested(requestId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshed,
    TResult? Function(String requestId)? interestedDonorsRequested,
    TResult? Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult? Function(String id)? requestFulfilled,
    TResult? Function(String id)? requestDeleted,
  }) {
    return interestedDonorsRequested?.call(requestId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshed,
    TResult Function(String requestId)? interestedDonorsRequested,
    TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult Function(String id)? requestFulfilled,
    TResult Function(String id)? requestDeleted,
    required TResult orElse(),
  }) {
    if (interestedDonorsRequested != null) {
      return interestedDonorsRequested(requestId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Refreshed value) refreshed,
    required TResult Function(_InterestedDonorsRequested value)
    interestedDonorsRequested,
    required TResult Function(_RequestUpdated value) requestUpdated,
    required TResult Function(_RequestFulfilled value) requestFulfilled,
    required TResult Function(_RequestDeleted value) requestDeleted,
  }) {
    return interestedDonorsRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Refreshed value)? refreshed,
    TResult? Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult? Function(_RequestUpdated value)? requestUpdated,
    TResult? Function(_RequestFulfilled value)? requestFulfilled,
    TResult? Function(_RequestDeleted value)? requestDeleted,
  }) {
    return interestedDonorsRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Refreshed value)? refreshed,
    TResult Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult Function(_RequestUpdated value)? requestUpdated,
    TResult Function(_RequestFulfilled value)? requestFulfilled,
    TResult Function(_RequestDeleted value)? requestDeleted,
    required TResult orElse(),
  }) {
    if (interestedDonorsRequested != null) {
      return interestedDonorsRequested(this);
    }
    return orElse();
  }
}

abstract class _InterestedDonorsRequested implements MyRequestsEvent {
  const factory _InterestedDonorsRequested(final String requestId) =
      _$InterestedDonorsRequestedImpl;

  String get requestId;

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterestedDonorsRequestedImplCopyWith<_$InterestedDonorsRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequestUpdatedImplCopyWith<$Res> {
  factory _$$RequestUpdatedImplCopyWith(
    _$RequestUpdatedImpl value,
    $Res Function(_$RequestUpdatedImpl) then,
  ) = __$$RequestUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String id,
    String patientName,
    String contact,
    String hospital,
    String address,
    String urgency,
    int units,
    DateTime needBy,
    String notes,
    double? latitude,
    double? longitude,
  });
}

/// @nodoc
class __$$RequestUpdatedImplCopyWithImpl<$Res>
    extends _$MyRequestsEventCopyWithImpl<$Res, _$RequestUpdatedImpl>
    implements _$$RequestUpdatedImplCopyWith<$Res> {
  __$$RequestUpdatedImplCopyWithImpl(
    _$RequestUpdatedImpl _value,
    $Res Function(_$RequestUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientName = null,
    Object? contact = null,
    Object? hospital = null,
    Object? address = null,
    Object? urgency = null,
    Object? units = null,
    Object? needBy = null,
    Object? notes = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(
      _$RequestUpdatedImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        patientName: null == patientName
            ? _value.patientName
            : patientName // ignore: cast_nullable_to_non_nullable
                  as String,
        contact: null == contact
            ? _value.contact
            : contact // ignore: cast_nullable_to_non_nullable
                  as String,
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
        units: null == units
            ? _value.units
            : units // ignore: cast_nullable_to_non_nullable
                  as int,
        needBy: null == needBy
            ? _value.needBy
            : needBy // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
      ),
    );
  }
}

/// @nodoc

class _$RequestUpdatedImpl implements _RequestUpdated {
  const _$RequestUpdatedImpl({
    required this.id,
    required this.patientName,
    required this.contact,
    required this.hospital,
    required this.address,
    required this.urgency,
    required this.units,
    required this.needBy,
    required this.notes,
    this.latitude,
    this.longitude,
  });

  @override
  final String id;
  @override
  final String patientName;
  @override
  final String contact;
  @override
  final String hospital;
  @override
  final String address;
  @override
  final String urgency;
  @override
  final int units;
  @override
  final DateTime needBy;
  @override
  final String notes;
  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  String toString() {
    return 'MyRequestsEvent.requestUpdated(id: $id, patientName: $patientName, contact: $contact, hospital: $hospital, address: $address, urgency: $urgency, units: $units, needBy: $needBy, notes: $notes, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestUpdatedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.hospital, hospital) ||
                other.hospital == hospital) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.urgency, urgency) || other.urgency == urgency) &&
            (identical(other.units, units) || other.units == units) &&
            (identical(other.needBy, needBy) || other.needBy == needBy) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    patientName,
    contact,
    hospital,
    address,
    urgency,
    units,
    needBy,
    notes,
    latitude,
    longitude,
  );

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestUpdatedImplCopyWith<_$RequestUpdatedImpl> get copyWith =>
      __$$RequestUpdatedImplCopyWithImpl<_$RequestUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshed,
    required TResult Function(String requestId) interestedDonorsRequested,
    required TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )
    requestUpdated,
    required TResult Function(String id) requestFulfilled,
    required TResult Function(String id) requestDeleted,
  }) {
    return requestUpdated(
      id,
      patientName,
      contact,
      hospital,
      address,
      urgency,
      units,
      needBy,
      notes,
      latitude,
      longitude,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshed,
    TResult? Function(String requestId)? interestedDonorsRequested,
    TResult? Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult? Function(String id)? requestFulfilled,
    TResult? Function(String id)? requestDeleted,
  }) {
    return requestUpdated?.call(
      id,
      patientName,
      contact,
      hospital,
      address,
      urgency,
      units,
      needBy,
      notes,
      latitude,
      longitude,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshed,
    TResult Function(String requestId)? interestedDonorsRequested,
    TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult Function(String id)? requestFulfilled,
    TResult Function(String id)? requestDeleted,
    required TResult orElse(),
  }) {
    if (requestUpdated != null) {
      return requestUpdated(
        id,
        patientName,
        contact,
        hospital,
        address,
        urgency,
        units,
        needBy,
        notes,
        latitude,
        longitude,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Refreshed value) refreshed,
    required TResult Function(_InterestedDonorsRequested value)
    interestedDonorsRequested,
    required TResult Function(_RequestUpdated value) requestUpdated,
    required TResult Function(_RequestFulfilled value) requestFulfilled,
    required TResult Function(_RequestDeleted value) requestDeleted,
  }) {
    return requestUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Refreshed value)? refreshed,
    TResult? Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult? Function(_RequestUpdated value)? requestUpdated,
    TResult? Function(_RequestFulfilled value)? requestFulfilled,
    TResult? Function(_RequestDeleted value)? requestDeleted,
  }) {
    return requestUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Refreshed value)? refreshed,
    TResult Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult Function(_RequestUpdated value)? requestUpdated,
    TResult Function(_RequestFulfilled value)? requestFulfilled,
    TResult Function(_RequestDeleted value)? requestDeleted,
    required TResult orElse(),
  }) {
    if (requestUpdated != null) {
      return requestUpdated(this);
    }
    return orElse();
  }
}

abstract class _RequestUpdated implements MyRequestsEvent {
  const factory _RequestUpdated({
    required final String id,
    required final String patientName,
    required final String contact,
    required final String hospital,
    required final String address,
    required final String urgency,
    required final int units,
    required final DateTime needBy,
    required final String notes,
    final double? latitude,
    final double? longitude,
  }) = _$RequestUpdatedImpl;

  String get id;
  String get patientName;
  String get contact;
  String get hospital;
  String get address;
  String get urgency;
  int get units;
  DateTime get needBy;
  String get notes;
  double? get latitude;
  double? get longitude;

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestUpdatedImplCopyWith<_$RequestUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequestFulfilledImplCopyWith<$Res> {
  factory _$$RequestFulfilledImplCopyWith(
    _$RequestFulfilledImpl value,
    $Res Function(_$RequestFulfilledImpl) then,
  ) = __$$RequestFulfilledImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$RequestFulfilledImplCopyWithImpl<$Res>
    extends _$MyRequestsEventCopyWithImpl<$Res, _$RequestFulfilledImpl>
    implements _$$RequestFulfilledImplCopyWith<$Res> {
  __$$RequestFulfilledImplCopyWithImpl(
    _$RequestFulfilledImpl _value,
    $Res Function(_$RequestFulfilledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$RequestFulfilledImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RequestFulfilledImpl implements _RequestFulfilled {
  const _$RequestFulfilledImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'MyRequestsEvent.requestFulfilled(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestFulfilledImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestFulfilledImplCopyWith<_$RequestFulfilledImpl> get copyWith =>
      __$$RequestFulfilledImplCopyWithImpl<_$RequestFulfilledImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshed,
    required TResult Function(String requestId) interestedDonorsRequested,
    required TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )
    requestUpdated,
    required TResult Function(String id) requestFulfilled,
    required TResult Function(String id) requestDeleted,
  }) {
    return requestFulfilled(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshed,
    TResult? Function(String requestId)? interestedDonorsRequested,
    TResult? Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult? Function(String id)? requestFulfilled,
    TResult? Function(String id)? requestDeleted,
  }) {
    return requestFulfilled?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshed,
    TResult Function(String requestId)? interestedDonorsRequested,
    TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult Function(String id)? requestFulfilled,
    TResult Function(String id)? requestDeleted,
    required TResult orElse(),
  }) {
    if (requestFulfilled != null) {
      return requestFulfilled(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Refreshed value) refreshed,
    required TResult Function(_InterestedDonorsRequested value)
    interestedDonorsRequested,
    required TResult Function(_RequestUpdated value) requestUpdated,
    required TResult Function(_RequestFulfilled value) requestFulfilled,
    required TResult Function(_RequestDeleted value) requestDeleted,
  }) {
    return requestFulfilled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Refreshed value)? refreshed,
    TResult? Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult? Function(_RequestUpdated value)? requestUpdated,
    TResult? Function(_RequestFulfilled value)? requestFulfilled,
    TResult? Function(_RequestDeleted value)? requestDeleted,
  }) {
    return requestFulfilled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Refreshed value)? refreshed,
    TResult Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult Function(_RequestUpdated value)? requestUpdated,
    TResult Function(_RequestFulfilled value)? requestFulfilled,
    TResult Function(_RequestDeleted value)? requestDeleted,
    required TResult orElse(),
  }) {
    if (requestFulfilled != null) {
      return requestFulfilled(this);
    }
    return orElse();
  }
}

abstract class _RequestFulfilled implements MyRequestsEvent {
  const factory _RequestFulfilled(final String id) = _$RequestFulfilledImpl;

  String get id;

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestFulfilledImplCopyWith<_$RequestFulfilledImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequestDeletedImplCopyWith<$Res> {
  factory _$$RequestDeletedImplCopyWith(
    _$RequestDeletedImpl value,
    $Res Function(_$RequestDeletedImpl) then,
  ) = __$$RequestDeletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$RequestDeletedImplCopyWithImpl<$Res>
    extends _$MyRequestsEventCopyWithImpl<$Res, _$RequestDeletedImpl>
    implements _$$RequestDeletedImplCopyWith<$Res> {
  __$$RequestDeletedImplCopyWithImpl(
    _$RequestDeletedImpl _value,
    $Res Function(_$RequestDeletedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$RequestDeletedImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RequestDeletedImpl implements _RequestDeleted {
  const _$RequestDeletedImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'MyRequestsEvent.requestDeleted(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestDeletedImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestDeletedImplCopyWith<_$RequestDeletedImpl> get copyWith =>
      __$$RequestDeletedImplCopyWithImpl<_$RequestDeletedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshed,
    required TResult Function(String requestId) interestedDonorsRequested,
    required TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )
    requestUpdated,
    required TResult Function(String id) requestFulfilled,
    required TResult Function(String id) requestDeleted,
  }) {
    return requestDeleted(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshed,
    TResult? Function(String requestId)? interestedDonorsRequested,
    TResult? Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult? Function(String id)? requestFulfilled,
    TResult? Function(String id)? requestDeleted,
  }) {
    return requestDeleted?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshed,
    TResult Function(String requestId)? interestedDonorsRequested,
    TResult Function(
      String id,
      String patientName,
      String contact,
      String hospital,
      String address,
      String urgency,
      int units,
      DateTime needBy,
      String notes,
      double? latitude,
      double? longitude,
    )?
    requestUpdated,
    TResult Function(String id)? requestFulfilled,
    TResult Function(String id)? requestDeleted,
    required TResult orElse(),
  }) {
    if (requestDeleted != null) {
      return requestDeleted(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Refreshed value) refreshed,
    required TResult Function(_InterestedDonorsRequested value)
    interestedDonorsRequested,
    required TResult Function(_RequestUpdated value) requestUpdated,
    required TResult Function(_RequestFulfilled value) requestFulfilled,
    required TResult Function(_RequestDeleted value) requestDeleted,
  }) {
    return requestDeleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Refreshed value)? refreshed,
    TResult? Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult? Function(_RequestUpdated value)? requestUpdated,
    TResult? Function(_RequestFulfilled value)? requestFulfilled,
    TResult? Function(_RequestDeleted value)? requestDeleted,
  }) {
    return requestDeleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Refreshed value)? refreshed,
    TResult Function(_InterestedDonorsRequested value)?
    interestedDonorsRequested,
    TResult Function(_RequestUpdated value)? requestUpdated,
    TResult Function(_RequestFulfilled value)? requestFulfilled,
    TResult Function(_RequestDeleted value)? requestDeleted,
    required TResult orElse(),
  }) {
    if (requestDeleted != null) {
      return requestDeleted(this);
    }
    return orElse();
  }
}

abstract class _RequestDeleted implements MyRequestsEvent {
  const factory _RequestDeleted(final String id) = _$RequestDeletedImpl;

  String get id;

  /// Create a copy of MyRequestsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestDeletedImplCopyWith<_$RequestDeletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
