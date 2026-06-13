// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_list_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ConversationListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String uid) watchStarted,
    required TResult Function(String value) searchChanged,
    required TResult Function(List<Conversation> conversations)
    conversationsReceived,
    required TResult Function(String message) errorOccurred,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String uid)? watchStarted,
    TResult? Function(String value)? searchChanged,
    TResult? Function(List<Conversation> conversations)? conversationsReceived,
    TResult? Function(String message)? errorOccurred,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String uid)? watchStarted,
    TResult Function(String value)? searchChanged,
    TResult Function(List<Conversation> conversations)? conversationsReceived,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_ConversationsReceived value)
    conversationsReceived,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_ConversationsReceived value)? conversationsReceived,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_ConversationsReceived value)? conversationsReceived,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationListEventCopyWith<$Res> {
  factory $ConversationListEventCopyWith(
    ConversationListEvent value,
    $Res Function(ConversationListEvent) then,
  ) = _$ConversationListEventCopyWithImpl<$Res, ConversationListEvent>;
}

/// @nodoc
class _$ConversationListEventCopyWithImpl<
  $Res,
  $Val extends ConversationListEvent
>
    implements $ConversationListEventCopyWith<$Res> {
  _$ConversationListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$WatchStartedImplCopyWith<$Res> {
  factory _$$WatchStartedImplCopyWith(
    _$WatchStartedImpl value,
    $Res Function(_$WatchStartedImpl) then,
  ) = __$$WatchStartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String uid});
}

/// @nodoc
class __$$WatchStartedImplCopyWithImpl<$Res>
    extends _$ConversationListEventCopyWithImpl<$Res, _$WatchStartedImpl>
    implements _$$WatchStartedImplCopyWith<$Res> {
  __$$WatchStartedImplCopyWithImpl(
    _$WatchStartedImpl _value,
    $Res Function(_$WatchStartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? uid = null}) {
    return _then(
      _$WatchStartedImpl(
        null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WatchStartedImpl implements _WatchStarted {
  const _$WatchStartedImpl(this.uid);

  @override
  final String uid;

  @override
  String toString() {
    return 'ConversationListEvent.watchStarted(uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchStartedImpl &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid);

  /// Create a copy of ConversationListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchStartedImplCopyWith<_$WatchStartedImpl> get copyWith =>
      __$$WatchStartedImplCopyWithImpl<_$WatchStartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String uid) watchStarted,
    required TResult Function(String value) searchChanged,
    required TResult Function(List<Conversation> conversations)
    conversationsReceived,
    required TResult Function(String message) errorOccurred,
  }) {
    return watchStarted(uid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String uid)? watchStarted,
    TResult? Function(String value)? searchChanged,
    TResult? Function(List<Conversation> conversations)? conversationsReceived,
    TResult? Function(String message)? errorOccurred,
  }) {
    return watchStarted?.call(uid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String uid)? watchStarted,
    TResult Function(String value)? searchChanged,
    TResult Function(List<Conversation> conversations)? conversationsReceived,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (watchStarted != null) {
      return watchStarted(uid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_ConversationsReceived value)
    conversationsReceived,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return watchStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_ConversationsReceived value)? conversationsReceived,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return watchStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_ConversationsReceived value)? conversationsReceived,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (watchStarted != null) {
      return watchStarted(this);
    }
    return orElse();
  }
}

abstract class _WatchStarted implements ConversationListEvent {
  const factory _WatchStarted(final String uid) = _$WatchStartedImpl;

  String get uid;

  /// Create a copy of ConversationListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchStartedImplCopyWith<_$WatchStartedImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$ConversationListEventCopyWithImpl<$Res, _$SearchChangedImpl>
    implements _$$SearchChangedImplCopyWith<$Res> {
  __$$SearchChangedImplCopyWithImpl(
    _$SearchChangedImpl _value,
    $Res Function(_$SearchChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationListEvent
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
    return 'ConversationListEvent.searchChanged(value: $value)';
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

  /// Create a copy of ConversationListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchChangedImplCopyWith<_$SearchChangedImpl> get copyWith =>
      __$$SearchChangedImplCopyWithImpl<_$SearchChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String uid) watchStarted,
    required TResult Function(String value) searchChanged,
    required TResult Function(List<Conversation> conversations)
    conversationsReceived,
    required TResult Function(String message) errorOccurred,
  }) {
    return searchChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String uid)? watchStarted,
    TResult? Function(String value)? searchChanged,
    TResult? Function(List<Conversation> conversations)? conversationsReceived,
    TResult? Function(String message)? errorOccurred,
  }) {
    return searchChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String uid)? watchStarted,
    TResult Function(String value)? searchChanged,
    TResult Function(List<Conversation> conversations)? conversationsReceived,
    TResult Function(String message)? errorOccurred,
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
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_ConversationsReceived value)
    conversationsReceived,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return searchChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_ConversationsReceived value)? conversationsReceived,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return searchChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_ConversationsReceived value)? conversationsReceived,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (searchChanged != null) {
      return searchChanged(this);
    }
    return orElse();
  }
}

abstract class _SearchChanged implements ConversationListEvent {
  const factory _SearchChanged(final String value) = _$SearchChangedImpl;

  String get value;

  /// Create a copy of ConversationListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchChangedImplCopyWith<_$SearchChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConversationsReceivedImplCopyWith<$Res> {
  factory _$$ConversationsReceivedImplCopyWith(
    _$ConversationsReceivedImpl value,
    $Res Function(_$ConversationsReceivedImpl) then,
  ) = __$$ConversationsReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Conversation> conversations});
}

/// @nodoc
class __$$ConversationsReceivedImplCopyWithImpl<$Res>
    extends
        _$ConversationListEventCopyWithImpl<$Res, _$ConversationsReceivedImpl>
    implements _$$ConversationsReceivedImplCopyWith<$Res> {
  __$$ConversationsReceivedImplCopyWithImpl(
    _$ConversationsReceivedImpl _value,
    $Res Function(_$ConversationsReceivedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversations = null}) {
    return _then(
      _$ConversationsReceivedImpl(
        null == conversations
            ? _value._conversations
            : conversations // ignore: cast_nullable_to_non_nullable
                  as List<Conversation>,
      ),
    );
  }
}

/// @nodoc

class _$ConversationsReceivedImpl implements _ConversationsReceived {
  const _$ConversationsReceivedImpl(final List<Conversation> conversations)
    : _conversations = conversations;

  final List<Conversation> _conversations;
  @override
  List<Conversation> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  String toString() {
    return 'ConversationListEvent.conversationsReceived(conversations: $conversations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationsReceivedImpl &&
            const DeepCollectionEquality().equals(
              other._conversations,
              _conversations,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_conversations),
  );

  /// Create a copy of ConversationListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationsReceivedImplCopyWith<_$ConversationsReceivedImpl>
  get copyWith =>
      __$$ConversationsReceivedImplCopyWithImpl<_$ConversationsReceivedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String uid) watchStarted,
    required TResult Function(String value) searchChanged,
    required TResult Function(List<Conversation> conversations)
    conversationsReceived,
    required TResult Function(String message) errorOccurred,
  }) {
    return conversationsReceived(conversations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String uid)? watchStarted,
    TResult? Function(String value)? searchChanged,
    TResult? Function(List<Conversation> conversations)? conversationsReceived,
    TResult? Function(String message)? errorOccurred,
  }) {
    return conversationsReceived?.call(conversations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String uid)? watchStarted,
    TResult Function(String value)? searchChanged,
    TResult Function(List<Conversation> conversations)? conversationsReceived,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (conversationsReceived != null) {
      return conversationsReceived(conversations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_ConversationsReceived value)
    conversationsReceived,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return conversationsReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_ConversationsReceived value)? conversationsReceived,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return conversationsReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_ConversationsReceived value)? conversationsReceived,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (conversationsReceived != null) {
      return conversationsReceived(this);
    }
    return orElse();
  }
}

abstract class _ConversationsReceived implements ConversationListEvent {
  const factory _ConversationsReceived(final List<Conversation> conversations) =
      _$ConversationsReceivedImpl;

  List<Conversation> get conversations;

  /// Create a copy of ConversationListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationsReceivedImplCopyWith<_$ConversationsReceivedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorOccurredImplCopyWith<$Res> {
  factory _$$ErrorOccurredImplCopyWith(
    _$ErrorOccurredImpl value,
    $Res Function(_$ErrorOccurredImpl) then,
  ) = __$$ErrorOccurredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorOccurredImplCopyWithImpl<$Res>
    extends _$ConversationListEventCopyWithImpl<$Res, _$ErrorOccurredImpl>
    implements _$$ErrorOccurredImplCopyWith<$Res> {
  __$$ErrorOccurredImplCopyWithImpl(
    _$ErrorOccurredImpl _value,
    $Res Function(_$ErrorOccurredImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorOccurredImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorOccurredImpl implements _ErrorOccurred {
  const _$ErrorOccurredImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ConversationListEvent.errorOccurred(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorOccurredImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ConversationListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorOccurredImplCopyWith<_$ErrorOccurredImpl> get copyWith =>
      __$$ErrorOccurredImplCopyWithImpl<_$ErrorOccurredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String uid) watchStarted,
    required TResult Function(String value) searchChanged,
    required TResult Function(List<Conversation> conversations)
    conversationsReceived,
    required TResult Function(String message) errorOccurred,
  }) {
    return errorOccurred(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String uid)? watchStarted,
    TResult? Function(String value)? searchChanged,
    TResult? Function(List<Conversation> conversations)? conversationsReceived,
    TResult? Function(String message)? errorOccurred,
  }) {
    return errorOccurred?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String uid)? watchStarted,
    TResult Function(String value)? searchChanged,
    TResult Function(List<Conversation> conversations)? conversationsReceived,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (errorOccurred != null) {
      return errorOccurred(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_ConversationsReceived value)
    conversationsReceived,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return errorOccurred(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_ConversationsReceived value)? conversationsReceived,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return errorOccurred?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_ConversationsReceived value)? conversationsReceived,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (errorOccurred != null) {
      return errorOccurred(this);
    }
    return orElse();
  }
}

abstract class _ErrorOccurred implements ConversationListEvent {
  const factory _ErrorOccurred(final String message) = _$ErrorOccurredImpl;

  String get message;

  /// Create a copy of ConversationListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorOccurredImplCopyWith<_$ErrorOccurredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
