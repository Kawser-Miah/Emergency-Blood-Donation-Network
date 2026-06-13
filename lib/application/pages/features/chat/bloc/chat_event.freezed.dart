// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )
    openRequested,
    required TResult Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )
    watchStarted,
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) messageSent,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function(List<Message> messages) messagesReceived,
    required TResult Function(bool online) presenceChanged,
    required TResult Function(String message) errorOccurred,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )?
    openRequested,
    TResult? Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )?
    watchStarted,
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? messageSent,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function(List<Message> messages)? messagesReceived,
    TResult? Function(bool online)? presenceChanged,
    TResult? Function(String message)? errorOccurred,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String currentUid, String otherUid, ChatSource chatSource)?
    openRequested,
    TResult Function(String conversationId, String currentUid, String otherUid)?
    watchStarted,
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? messageSent,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function(List<Message> messages)? messagesReceived,
    TResult Function(bool online)? presenceChanged,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OpenRequested value) openRequested,
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_MessagesReceived value) messagesReceived,
    required TResult Function(_PresenceChanged value) presenceChanged,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OpenRequested value)? openRequested,
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_MessagesReceived value)? messagesReceived,
    TResult? Function(_PresenceChanged value)? presenceChanged,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OpenRequested value)? openRequested,
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_MessagesReceived value)? messagesReceived,
    TResult Function(_PresenceChanged value)? presenceChanged,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEventCopyWith<$Res> {
  factory $ChatEventCopyWith(ChatEvent value, $Res Function(ChatEvent) then) =
      _$ChatEventCopyWithImpl<$Res, ChatEvent>;
}

/// @nodoc
class _$ChatEventCopyWithImpl<$Res, $Val extends ChatEvent>
    implements $ChatEventCopyWith<$Res> {
  _$ChatEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$OpenRequestedImplCopyWith<$Res> {
  factory _$$OpenRequestedImplCopyWith(
    _$OpenRequestedImpl value,
    $Res Function(_$OpenRequestedImpl) then,
  ) = __$$OpenRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String currentUid, String otherUid, ChatSource chatSource});

  $ChatSourceCopyWith<$Res> get chatSource;
}

/// @nodoc
class __$$OpenRequestedImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$OpenRequestedImpl>
    implements _$$OpenRequestedImplCopyWith<$Res> {
  __$$OpenRequestedImplCopyWithImpl(
    _$OpenRequestedImpl _value,
    $Res Function(_$OpenRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUid = null,
    Object? otherUid = null,
    Object? chatSource = null,
  }) {
    return _then(
      _$OpenRequestedImpl(
        currentUid: null == currentUid
            ? _value.currentUid
            : currentUid // ignore: cast_nullable_to_non_nullable
                  as String,
        otherUid: null == otherUid
            ? _value.otherUid
            : otherUid // ignore: cast_nullable_to_non_nullable
                  as String,
        chatSource: null == chatSource
            ? _value.chatSource
            : chatSource // ignore: cast_nullable_to_non_nullable
                  as ChatSource,
      ),
    );
  }

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatSourceCopyWith<$Res> get chatSource {
    return $ChatSourceCopyWith<$Res>(_value.chatSource, (value) {
      return _then(_value.copyWith(chatSource: value));
    });
  }
}

/// @nodoc

class _$OpenRequestedImpl implements _OpenRequested {
  const _$OpenRequestedImpl({
    required this.currentUid,
    required this.otherUid,
    required this.chatSource,
  });

  @override
  final String currentUid;
  @override
  final String otherUid;
  @override
  final ChatSource chatSource;

  @override
  String toString() {
    return 'ChatEvent.openRequested(currentUid: $currentUid, otherUid: $otherUid, chatSource: $chatSource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpenRequestedImpl &&
            (identical(other.currentUid, currentUid) ||
                other.currentUid == currentUid) &&
            (identical(other.otherUid, otherUid) ||
                other.otherUid == otherUid) &&
            (identical(other.chatSource, chatSource) ||
                other.chatSource == chatSource));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentUid, otherUid, chatSource);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpenRequestedImplCopyWith<_$OpenRequestedImpl> get copyWith =>
      __$$OpenRequestedImplCopyWithImpl<_$OpenRequestedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )
    openRequested,
    required TResult Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )
    watchStarted,
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) messageSent,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function(List<Message> messages) messagesReceived,
    required TResult Function(bool online) presenceChanged,
    required TResult Function(String message) errorOccurred,
  }) {
    return openRequested(currentUid, otherUid, chatSource);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )?
    openRequested,
    TResult? Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )?
    watchStarted,
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? messageSent,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function(List<Message> messages)? messagesReceived,
    TResult? Function(bool online)? presenceChanged,
    TResult? Function(String message)? errorOccurred,
  }) {
    return openRequested?.call(currentUid, otherUid, chatSource);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String currentUid, String otherUid, ChatSource chatSource)?
    openRequested,
    TResult Function(String conversationId, String currentUid, String otherUid)?
    watchStarted,
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? messageSent,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function(List<Message> messages)? messagesReceived,
    TResult Function(bool online)? presenceChanged,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (openRequested != null) {
      return openRequested(currentUid, otherUid, chatSource);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OpenRequested value) openRequested,
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_MessagesReceived value) messagesReceived,
    required TResult Function(_PresenceChanged value) presenceChanged,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return openRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OpenRequested value)? openRequested,
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_MessagesReceived value)? messagesReceived,
    TResult? Function(_PresenceChanged value)? presenceChanged,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return openRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OpenRequested value)? openRequested,
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_MessagesReceived value)? messagesReceived,
    TResult Function(_PresenceChanged value)? presenceChanged,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (openRequested != null) {
      return openRequested(this);
    }
    return orElse();
  }
}

abstract class _OpenRequested implements ChatEvent {
  const factory _OpenRequested({
    required final String currentUid,
    required final String otherUid,
    required final ChatSource chatSource,
  }) = _$OpenRequestedImpl;

  String get currentUid;
  String get otherUid;
  ChatSource get chatSource;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpenRequestedImplCopyWith<_$OpenRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchStartedImplCopyWith<$Res> {
  factory _$$WatchStartedImplCopyWith(
    _$WatchStartedImpl value,
    $Res Function(_$WatchStartedImpl) then,
  ) = __$$WatchStartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, String currentUid, String otherUid});
}

/// @nodoc
class __$$WatchStartedImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$WatchStartedImpl>
    implements _$$WatchStartedImplCopyWith<$Res> {
  __$$WatchStartedImplCopyWithImpl(
    _$WatchStartedImpl _value,
    $Res Function(_$WatchStartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? currentUid = null,
    Object? otherUid = null,
  }) {
    return _then(
      _$WatchStartedImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentUid: null == currentUid
            ? _value.currentUid
            : currentUid // ignore: cast_nullable_to_non_nullable
                  as String,
        otherUid: null == otherUid
            ? _value.otherUid
            : otherUid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WatchStartedImpl implements _WatchStarted {
  const _$WatchStartedImpl({
    required this.conversationId,
    required this.currentUid,
    required this.otherUid,
  });

  @override
  final String conversationId;
  @override
  final String currentUid;
  @override
  final String otherUid;

  @override
  String toString() {
    return 'ChatEvent.watchStarted(conversationId: $conversationId, currentUid: $currentUid, otherUid: $otherUid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchStartedImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.currentUid, currentUid) ||
                other.currentUid == currentUid) &&
            (identical(other.otherUid, otherUid) ||
                other.otherUid == otherUid));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, currentUid, otherUid);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchStartedImplCopyWith<_$WatchStartedImpl> get copyWith =>
      __$$WatchStartedImplCopyWithImpl<_$WatchStartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )
    openRequested,
    required TResult Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )
    watchStarted,
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) messageSent,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function(List<Message> messages) messagesReceived,
    required TResult Function(bool online) presenceChanged,
    required TResult Function(String message) errorOccurred,
  }) {
    return watchStarted(conversationId, currentUid, otherUid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )?
    openRequested,
    TResult? Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )?
    watchStarted,
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? messageSent,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function(List<Message> messages)? messagesReceived,
    TResult? Function(bool online)? presenceChanged,
    TResult? Function(String message)? errorOccurred,
  }) {
    return watchStarted?.call(conversationId, currentUid, otherUid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String currentUid, String otherUid, ChatSource chatSource)?
    openRequested,
    TResult Function(String conversationId, String currentUid, String otherUid)?
    watchStarted,
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? messageSent,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function(List<Message> messages)? messagesReceived,
    TResult Function(bool online)? presenceChanged,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (watchStarted != null) {
      return watchStarted(conversationId, currentUid, otherUid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OpenRequested value) openRequested,
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_MessagesReceived value) messagesReceived,
    required TResult Function(_PresenceChanged value) presenceChanged,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return watchStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OpenRequested value)? openRequested,
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_MessagesReceived value)? messagesReceived,
    TResult? Function(_PresenceChanged value)? presenceChanged,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return watchStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OpenRequested value)? openRequested,
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_MessagesReceived value)? messagesReceived,
    TResult Function(_PresenceChanged value)? presenceChanged,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (watchStarted != null) {
      return watchStarted(this);
    }
    return orElse();
  }
}

abstract class _WatchStarted implements ChatEvent {
  const factory _WatchStarted({
    required final String conversationId,
    required final String currentUid,
    required final String otherUid,
  }) = _$WatchStartedImpl;

  String get conversationId;
  String get currentUid;
  String get otherUid;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchStartedImplCopyWith<_$WatchStartedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InputChangedImplCopyWith<$Res> {
  factory _$$InputChangedImplCopyWith(
    _$InputChangedImpl value,
    $Res Function(_$InputChangedImpl) then,
  ) = __$$InputChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$InputChangedImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$InputChangedImpl>
    implements _$$InputChangedImplCopyWith<$Res> {
  __$$InputChangedImplCopyWithImpl(
    _$InputChangedImpl _value,
    $Res Function(_$InputChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$InputChangedImpl(
        null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$InputChangedImpl implements _InputChanged {
  const _$InputChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'ChatEvent.inputChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InputChangedImplCopyWith<_$InputChangedImpl> get copyWith =>
      __$$InputChangedImplCopyWithImpl<_$InputChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )
    openRequested,
    required TResult Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )
    watchStarted,
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) messageSent,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function(List<Message> messages) messagesReceived,
    required TResult Function(bool online) presenceChanged,
    required TResult Function(String message) errorOccurred,
  }) {
    return inputChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )?
    openRequested,
    TResult? Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )?
    watchStarted,
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? messageSent,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function(List<Message> messages)? messagesReceived,
    TResult? Function(bool online)? presenceChanged,
    TResult? Function(String message)? errorOccurred,
  }) {
    return inputChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String currentUid, String otherUid, ChatSource chatSource)?
    openRequested,
    TResult Function(String conversationId, String currentUid, String otherUid)?
    watchStarted,
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? messageSent,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function(List<Message> messages)? messagesReceived,
    TResult Function(bool online)? presenceChanged,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (inputChanged != null) {
      return inputChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OpenRequested value) openRequested,
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_MessagesReceived value) messagesReceived,
    required TResult Function(_PresenceChanged value) presenceChanged,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return inputChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OpenRequested value)? openRequested,
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_MessagesReceived value)? messagesReceived,
    TResult? Function(_PresenceChanged value)? presenceChanged,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return inputChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OpenRequested value)? openRequested,
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_MessagesReceived value)? messagesReceived,
    TResult Function(_PresenceChanged value)? presenceChanged,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (inputChanged != null) {
      return inputChanged(this);
    }
    return orElse();
  }
}

abstract class _InputChanged implements ChatEvent {
  const factory _InputChanged(final String value) = _$InputChangedImpl;

  String get value;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InputChangedImplCopyWith<_$InputChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessageSentImplCopyWith<$Res> {
  factory _$$MessageSentImplCopyWith(
    _$MessageSentImpl value,
    $Res Function(_$MessageSentImpl) then,
  ) = __$$MessageSentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$MessageSentImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$MessageSentImpl>
    implements _$$MessageSentImplCopyWith<$Res> {
  __$$MessageSentImplCopyWithImpl(
    _$MessageSentImpl _value,
    $Res Function(_$MessageSentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null}) {
    return _then(
      _$MessageSentImpl(
        null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MessageSentImpl implements _MessageSent {
  const _$MessageSentImpl(this.text);

  @override
  final String text;

  @override
  String toString() {
    return 'ChatEvent.messageSent(text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageSentImpl &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageSentImplCopyWith<_$MessageSentImpl> get copyWith =>
      __$$MessageSentImplCopyWithImpl<_$MessageSentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )
    openRequested,
    required TResult Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )
    watchStarted,
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) messageSent,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function(List<Message> messages) messagesReceived,
    required TResult Function(bool online) presenceChanged,
    required TResult Function(String message) errorOccurred,
  }) {
    return messageSent(text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )?
    openRequested,
    TResult? Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )?
    watchStarted,
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? messageSent,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function(List<Message> messages)? messagesReceived,
    TResult? Function(bool online)? presenceChanged,
    TResult? Function(String message)? errorOccurred,
  }) {
    return messageSent?.call(text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String currentUid, String otherUid, ChatSource chatSource)?
    openRequested,
    TResult Function(String conversationId, String currentUid, String otherUid)?
    watchStarted,
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? messageSent,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function(List<Message> messages)? messagesReceived,
    TResult Function(bool online)? presenceChanged,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (messageSent != null) {
      return messageSent(text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OpenRequested value) openRequested,
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_MessagesReceived value) messagesReceived,
    required TResult Function(_PresenceChanged value) presenceChanged,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return messageSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OpenRequested value)? openRequested,
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_MessagesReceived value)? messagesReceived,
    TResult? Function(_PresenceChanged value)? presenceChanged,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return messageSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OpenRequested value)? openRequested,
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_MessagesReceived value)? messagesReceived,
    TResult Function(_PresenceChanged value)? presenceChanged,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (messageSent != null) {
      return messageSent(this);
    }
    return orElse();
  }
}

abstract class _MessageSent implements ChatEvent {
  const factory _MessageSent(final String text) = _$MessageSentImpl;

  String get text;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageSentImplCopyWith<_$MessageSentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AttachmentToggledImplCopyWith<$Res> {
  factory _$$AttachmentToggledImplCopyWith(
    _$AttachmentToggledImpl value,
    $Res Function(_$AttachmentToggledImpl) then,
  ) = __$$AttachmentToggledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AttachmentToggledImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$AttachmentToggledImpl>
    implements _$$AttachmentToggledImplCopyWith<$Res> {
  __$$AttachmentToggledImplCopyWithImpl(
    _$AttachmentToggledImpl _value,
    $Res Function(_$AttachmentToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AttachmentToggledImpl implements _AttachmentToggled {
  const _$AttachmentToggledImpl();

  @override
  String toString() {
    return 'ChatEvent.attachmentToggled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AttachmentToggledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )
    openRequested,
    required TResult Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )
    watchStarted,
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) messageSent,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function(List<Message> messages) messagesReceived,
    required TResult Function(bool online) presenceChanged,
    required TResult Function(String message) errorOccurred,
  }) {
    return attachmentToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )?
    openRequested,
    TResult? Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )?
    watchStarted,
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? messageSent,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function(List<Message> messages)? messagesReceived,
    TResult? Function(bool online)? presenceChanged,
    TResult? Function(String message)? errorOccurred,
  }) {
    return attachmentToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String currentUid, String otherUid, ChatSource chatSource)?
    openRequested,
    TResult Function(String conversationId, String currentUid, String otherUid)?
    watchStarted,
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? messageSent,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function(List<Message> messages)? messagesReceived,
    TResult Function(bool online)? presenceChanged,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (attachmentToggled != null) {
      return attachmentToggled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OpenRequested value) openRequested,
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_MessagesReceived value) messagesReceived,
    required TResult Function(_PresenceChanged value) presenceChanged,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return attachmentToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OpenRequested value)? openRequested,
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_MessagesReceived value)? messagesReceived,
    TResult? Function(_PresenceChanged value)? presenceChanged,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return attachmentToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OpenRequested value)? openRequested,
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_MessagesReceived value)? messagesReceived,
    TResult Function(_PresenceChanged value)? presenceChanged,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (attachmentToggled != null) {
      return attachmentToggled(this);
    }
    return orElse();
  }
}

abstract class _AttachmentToggled implements ChatEvent {
  const factory _AttachmentToggled() = _$AttachmentToggledImpl;
}

/// @nodoc
abstract class _$$AttachmentClosedImplCopyWith<$Res> {
  factory _$$AttachmentClosedImplCopyWith(
    _$AttachmentClosedImpl value,
    $Res Function(_$AttachmentClosedImpl) then,
  ) = __$$AttachmentClosedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AttachmentClosedImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$AttachmentClosedImpl>
    implements _$$AttachmentClosedImplCopyWith<$Res> {
  __$$AttachmentClosedImplCopyWithImpl(
    _$AttachmentClosedImpl _value,
    $Res Function(_$AttachmentClosedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AttachmentClosedImpl implements _AttachmentClosed {
  const _$AttachmentClosedImpl();

  @override
  String toString() {
    return 'ChatEvent.attachmentClosed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AttachmentClosedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )
    openRequested,
    required TResult Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )
    watchStarted,
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) messageSent,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function(List<Message> messages) messagesReceived,
    required TResult Function(bool online) presenceChanged,
    required TResult Function(String message) errorOccurred,
  }) {
    return attachmentClosed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )?
    openRequested,
    TResult? Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )?
    watchStarted,
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? messageSent,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function(List<Message> messages)? messagesReceived,
    TResult? Function(bool online)? presenceChanged,
    TResult? Function(String message)? errorOccurred,
  }) {
    return attachmentClosed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String currentUid, String otherUid, ChatSource chatSource)?
    openRequested,
    TResult Function(String conversationId, String currentUid, String otherUid)?
    watchStarted,
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? messageSent,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function(List<Message> messages)? messagesReceived,
    TResult Function(bool online)? presenceChanged,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (attachmentClosed != null) {
      return attachmentClosed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OpenRequested value) openRequested,
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_MessagesReceived value) messagesReceived,
    required TResult Function(_PresenceChanged value) presenceChanged,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return attachmentClosed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OpenRequested value)? openRequested,
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_MessagesReceived value)? messagesReceived,
    TResult? Function(_PresenceChanged value)? presenceChanged,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return attachmentClosed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OpenRequested value)? openRequested,
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_MessagesReceived value)? messagesReceived,
    TResult Function(_PresenceChanged value)? presenceChanged,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (attachmentClosed != null) {
      return attachmentClosed(this);
    }
    return orElse();
  }
}

abstract class _AttachmentClosed implements ChatEvent {
  const factory _AttachmentClosed() = _$AttachmentClosedImpl;
}

/// @nodoc
abstract class _$$MessagesReceivedImplCopyWith<$Res> {
  factory _$$MessagesReceivedImplCopyWith(
    _$MessagesReceivedImpl value,
    $Res Function(_$MessagesReceivedImpl) then,
  ) = __$$MessagesReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Message> messages});
}

/// @nodoc
class __$$MessagesReceivedImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$MessagesReceivedImpl>
    implements _$$MessagesReceivedImplCopyWith<$Res> {
  __$$MessagesReceivedImplCopyWithImpl(
    _$MessagesReceivedImpl _value,
    $Res Function(_$MessagesReceivedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messages = null}) {
    return _then(
      _$MessagesReceivedImpl(
        null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<Message>,
      ),
    );
  }
}

/// @nodoc

class _$MessagesReceivedImpl implements _MessagesReceived {
  const _$MessagesReceivedImpl(final List<Message> messages)
    : _messages = messages;

  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'ChatEvent.messagesReceived(messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagesReceivedImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagesReceivedImplCopyWith<_$MessagesReceivedImpl> get copyWith =>
      __$$MessagesReceivedImplCopyWithImpl<_$MessagesReceivedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )
    openRequested,
    required TResult Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )
    watchStarted,
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) messageSent,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function(List<Message> messages) messagesReceived,
    required TResult Function(bool online) presenceChanged,
    required TResult Function(String message) errorOccurred,
  }) {
    return messagesReceived(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )?
    openRequested,
    TResult? Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )?
    watchStarted,
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? messageSent,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function(List<Message> messages)? messagesReceived,
    TResult? Function(bool online)? presenceChanged,
    TResult? Function(String message)? errorOccurred,
  }) {
    return messagesReceived?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String currentUid, String otherUid, ChatSource chatSource)?
    openRequested,
    TResult Function(String conversationId, String currentUid, String otherUid)?
    watchStarted,
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? messageSent,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function(List<Message> messages)? messagesReceived,
    TResult Function(bool online)? presenceChanged,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (messagesReceived != null) {
      return messagesReceived(messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OpenRequested value) openRequested,
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_MessagesReceived value) messagesReceived,
    required TResult Function(_PresenceChanged value) presenceChanged,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return messagesReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OpenRequested value)? openRequested,
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_MessagesReceived value)? messagesReceived,
    TResult? Function(_PresenceChanged value)? presenceChanged,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return messagesReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OpenRequested value)? openRequested,
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_MessagesReceived value)? messagesReceived,
    TResult Function(_PresenceChanged value)? presenceChanged,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (messagesReceived != null) {
      return messagesReceived(this);
    }
    return orElse();
  }
}

abstract class _MessagesReceived implements ChatEvent {
  const factory _MessagesReceived(final List<Message> messages) =
      _$MessagesReceivedImpl;

  List<Message> get messages;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessagesReceivedImplCopyWith<_$MessagesReceivedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PresenceChangedImplCopyWith<$Res> {
  factory _$$PresenceChangedImplCopyWith(
    _$PresenceChangedImpl value,
    $Res Function(_$PresenceChangedImpl) then,
  ) = __$$PresenceChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool online});
}

/// @nodoc
class __$$PresenceChangedImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$PresenceChangedImpl>
    implements _$$PresenceChangedImplCopyWith<$Res> {
  __$$PresenceChangedImplCopyWithImpl(
    _$PresenceChangedImpl _value,
    $Res Function(_$PresenceChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? online = null}) {
    return _then(
      _$PresenceChangedImpl(
        null == online
            ? _value.online
            : online // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$PresenceChangedImpl implements _PresenceChanged {
  const _$PresenceChangedImpl(this.online);

  @override
  final bool online;

  @override
  String toString() {
    return 'ChatEvent.presenceChanged(online: $online)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresenceChangedImpl &&
            (identical(other.online, online) || other.online == online));
  }

  @override
  int get hashCode => Object.hash(runtimeType, online);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresenceChangedImplCopyWith<_$PresenceChangedImpl> get copyWith =>
      __$$PresenceChangedImplCopyWithImpl<_$PresenceChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )
    openRequested,
    required TResult Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )
    watchStarted,
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) messageSent,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function(List<Message> messages) messagesReceived,
    required TResult Function(bool online) presenceChanged,
    required TResult Function(String message) errorOccurred,
  }) {
    return presenceChanged(online);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )?
    openRequested,
    TResult? Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )?
    watchStarted,
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? messageSent,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function(List<Message> messages)? messagesReceived,
    TResult? Function(bool online)? presenceChanged,
    TResult? Function(String message)? errorOccurred,
  }) {
    return presenceChanged?.call(online);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String currentUid, String otherUid, ChatSource chatSource)?
    openRequested,
    TResult Function(String conversationId, String currentUid, String otherUid)?
    watchStarted,
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? messageSent,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function(List<Message> messages)? messagesReceived,
    TResult Function(bool online)? presenceChanged,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (presenceChanged != null) {
      return presenceChanged(online);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OpenRequested value) openRequested,
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_MessagesReceived value) messagesReceived,
    required TResult Function(_PresenceChanged value) presenceChanged,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return presenceChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OpenRequested value)? openRequested,
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_MessagesReceived value)? messagesReceived,
    TResult? Function(_PresenceChanged value)? presenceChanged,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return presenceChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OpenRequested value)? openRequested,
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_MessagesReceived value)? messagesReceived,
    TResult Function(_PresenceChanged value)? presenceChanged,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (presenceChanged != null) {
      return presenceChanged(this);
    }
    return orElse();
  }
}

abstract class _PresenceChanged implements ChatEvent {
  const factory _PresenceChanged(final bool online) = _$PresenceChangedImpl;

  bool get online;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresenceChangedImplCopyWith<_$PresenceChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$ChatEventCopyWithImpl<$Res, _$ErrorOccurredImpl>
    implements _$$ErrorOccurredImplCopyWith<$Res> {
  __$$ErrorOccurredImplCopyWithImpl(
    _$ErrorOccurredImpl _value,
    $Res Function(_$ErrorOccurredImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
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
    return 'ChatEvent.errorOccurred(message: $message)';
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

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorOccurredImplCopyWith<_$ErrorOccurredImpl> get copyWith =>
      __$$ErrorOccurredImplCopyWithImpl<_$ErrorOccurredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )
    openRequested,
    required TResult Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )
    watchStarted,
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) messageSent,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function(List<Message> messages) messagesReceived,
    required TResult Function(bool online) presenceChanged,
    required TResult Function(String message) errorOccurred,
  }) {
    return errorOccurred(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String currentUid,
      String otherUid,
      ChatSource chatSource,
    )?
    openRequested,
    TResult? Function(
      String conversationId,
      String currentUid,
      String otherUid,
    )?
    watchStarted,
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? messageSent,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function(List<Message> messages)? messagesReceived,
    TResult? Function(bool online)? presenceChanged,
    TResult? Function(String message)? errorOccurred,
  }) {
    return errorOccurred?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String currentUid, String otherUid, ChatSource chatSource)?
    openRequested,
    TResult Function(String conversationId, String currentUid, String otherUid)?
    watchStarted,
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? messageSent,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function(List<Message> messages)? messagesReceived,
    TResult Function(bool online)? presenceChanged,
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
    required TResult Function(_OpenRequested value) openRequested,
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_MessagesReceived value) messagesReceived,
    required TResult Function(_PresenceChanged value) presenceChanged,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return errorOccurred(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_OpenRequested value)? openRequested,
    TResult? Function(_WatchStarted value)? watchStarted,
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_MessagesReceived value)? messagesReceived,
    TResult? Function(_PresenceChanged value)? presenceChanged,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return errorOccurred?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OpenRequested value)? openRequested,
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_MessagesReceived value)? messagesReceived,
    TResult Function(_PresenceChanged value)? presenceChanged,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (errorOccurred != null) {
      return errorOccurred(this);
    }
    return orElse();
  }
}

abstract class _ErrorOccurred implements ChatEvent {
  const factory _ErrorOccurred(final String message) = _$ErrorOccurredImpl;

  String get message;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorOccurredImplCopyWith<_$ErrorOccurredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
