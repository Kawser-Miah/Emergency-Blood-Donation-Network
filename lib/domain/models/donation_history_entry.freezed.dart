// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'donation_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DonationHistoryEntry {
  String get id => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get hospital => throw _privateConstructorUsedError;
  String get bloodGroup => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Create a copy of DonationHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DonationHistoryEntryCopyWith<DonationHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DonationHistoryEntryCopyWith<$Res> {
  factory $DonationHistoryEntryCopyWith(
    DonationHistoryEntry value,
    $Res Function(DonationHistoryEntry) then,
  ) = _$DonationHistoryEntryCopyWithImpl<$Res, DonationHistoryEntry>;
  @useResult
  $Res call({
    String id,
    String date,
    String hospital,
    String bloodGroup,
    String status,
  });
}

/// @nodoc
class _$DonationHistoryEntryCopyWithImpl<
  $Res,
  $Val extends DonationHistoryEntry
>
    implements $DonationHistoryEntryCopyWith<$Res> {
  _$DonationHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DonationHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? hospital = null,
    Object? bloodGroup = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            hospital: null == hospital
                ? _value.hospital
                : hospital // ignore: cast_nullable_to_non_nullable
                      as String,
            bloodGroup: null == bloodGroup
                ? _value.bloodGroup
                : bloodGroup // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DonationHistoryEntryImplCopyWith<$Res>
    implements $DonationHistoryEntryCopyWith<$Res> {
  factory _$$DonationHistoryEntryImplCopyWith(
    _$DonationHistoryEntryImpl value,
    $Res Function(_$DonationHistoryEntryImpl) then,
  ) = __$$DonationHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String date,
    String hospital,
    String bloodGroup,
    String status,
  });
}

/// @nodoc
class __$$DonationHistoryEntryImplCopyWithImpl<$Res>
    extends _$DonationHistoryEntryCopyWithImpl<$Res, _$DonationHistoryEntryImpl>
    implements _$$DonationHistoryEntryImplCopyWith<$Res> {
  __$$DonationHistoryEntryImplCopyWithImpl(
    _$DonationHistoryEntryImpl _value,
    $Res Function(_$DonationHistoryEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DonationHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? hospital = null,
    Object? bloodGroup = null,
    Object? status = null,
  }) {
    return _then(
      _$DonationHistoryEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        hospital: null == hospital
            ? _value.hospital
            : hospital // ignore: cast_nullable_to_non_nullable
                  as String,
        bloodGroup: null == bloodGroup
            ? _value.bloodGroup
            : bloodGroup // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DonationHistoryEntryImpl implements _DonationHistoryEntry {
  const _$DonationHistoryEntryImpl({
    required this.id,
    required this.date,
    required this.hospital,
    required this.bloodGroup,
    required this.status,
  });

  @override
  final String id;
  @override
  final String date;
  @override
  final String hospital;
  @override
  final String bloodGroup;
  @override
  final String status;

  @override
  String toString() {
    return 'DonationHistoryEntry(id: $id, date: $date, hospital: $hospital, bloodGroup: $bloodGroup, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DonationHistoryEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.hospital, hospital) ||
                other.hospital == hospital) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, date, hospital, bloodGroup, status);

  /// Create a copy of DonationHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DonationHistoryEntryImplCopyWith<_$DonationHistoryEntryImpl>
  get copyWith =>
      __$$DonationHistoryEntryImplCopyWithImpl<_$DonationHistoryEntryImpl>(
        this,
        _$identity,
      );
}

abstract class _DonationHistoryEntry implements DonationHistoryEntry {
  const factory _DonationHistoryEntry({
    required final String id,
    required final String date,
    required final String hospital,
    required final String bloodGroup,
    required final String status,
  }) = _$DonationHistoryEntryImpl;

  @override
  String get id;
  @override
  String get date;
  @override
  String get hospital;
  @override
  String get bloodGroup;
  @override
  String get status;

  /// Create a copy of DonationHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DonationHistoryEntryImplCopyWith<_$DonationHistoryEntryImpl>
  get copyWith => throw _privateConstructorUsedError;
}
