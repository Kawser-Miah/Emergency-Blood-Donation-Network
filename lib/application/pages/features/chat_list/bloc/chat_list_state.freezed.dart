// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatListState {
  String get search => throw _privateConstructorUsedError;
  List<ChatSummary> get chats => throw _privateConstructorUsedError;

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatListStateCopyWith<ChatListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatListStateCopyWith<$Res> {
  factory $ChatListStateCopyWith(
    ChatListState value,
    $Res Function(ChatListState) then,
  ) = _$ChatListStateCopyWithImpl<$Res, ChatListState>;
  @useResult
  $Res call({String search, List<ChatSummary> chats});
}

/// @nodoc
class _$ChatListStateCopyWithImpl<$Res, $Val extends ChatListState>
    implements $ChatListStateCopyWith<$Res> {
  _$ChatListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? search = null, Object? chats = null}) {
    return _then(
      _value.copyWith(
            search: null == search
                ? _value.search
                : search // ignore: cast_nullable_to_non_nullable
                      as String,
            chats: null == chats
                ? _value.chats
                : chats // ignore: cast_nullable_to_non_nullable
                      as List<ChatSummary>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatListStateImplCopyWith<$Res>
    implements $ChatListStateCopyWith<$Res> {
  factory _$$ChatListStateImplCopyWith(
    _$ChatListStateImpl value,
    $Res Function(_$ChatListStateImpl) then,
  ) = __$$ChatListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String search, List<ChatSummary> chats});
}

/// @nodoc
class __$$ChatListStateImplCopyWithImpl<$Res>
    extends _$ChatListStateCopyWithImpl<$Res, _$ChatListStateImpl>
    implements _$$ChatListStateImplCopyWith<$Res> {
  __$$ChatListStateImplCopyWithImpl(
    _$ChatListStateImpl _value,
    $Res Function(_$ChatListStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? search = null, Object? chats = null}) {
    return _then(
      _$ChatListStateImpl(
        search: null == search
            ? _value.search
            : search // ignore: cast_nullable_to_non_nullable
                  as String,
        chats: null == chats
            ? _value._chats
            : chats // ignore: cast_nullable_to_non_nullable
                  as List<ChatSummary>,
      ),
    );
  }
}

/// @nodoc

class _$ChatListStateImpl implements _ChatListState {
  const _$ChatListStateImpl({
    this.search = '',
    required final List<ChatSummary> chats,
  }) : _chats = chats;

  @override
  @JsonKey()
  final String search;
  final List<ChatSummary> _chats;
  @override
  List<ChatSummary> get chats {
    if (_chats is EqualUnmodifiableListView) return _chats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chats);
  }

  @override
  String toString() {
    return 'ChatListState(search: $search, chats: $chats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListStateImpl &&
            (identical(other.search, search) || other.search == search) &&
            const DeepCollectionEquality().equals(other._chats, _chats));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    search,
    const DeepCollectionEquality().hash(_chats),
  );

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListStateImplCopyWith<_$ChatListStateImpl> get copyWith =>
      __$$ChatListStateImplCopyWithImpl<_$ChatListStateImpl>(this, _$identity);
}

abstract class _ChatListState implements ChatListState {
  const factory _ChatListState({
    final String search,
    required final List<ChatSummary> chats,
  }) = _$ChatListStateImpl;

  @override
  String get search;
  @override
  List<ChatSummary> get chats;

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatListStateImplCopyWith<_$ChatListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
