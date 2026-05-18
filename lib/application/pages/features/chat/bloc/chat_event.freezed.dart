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
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) sendRequested,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function() replyArrived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? sendRequested,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function()? replyArrived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? sendRequested,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function()? replyArrived,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_SendRequested value) sendRequested,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_ReplyArrived value) replyArrived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_SendRequested value)? sendRequested,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_ReplyArrived value)? replyArrived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_SendRequested value)? sendRequested,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_ReplyArrived value)? replyArrived,
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
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) sendRequested,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function() replyArrived,
  }) {
    return inputChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? sendRequested,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function()? replyArrived,
  }) {
    return inputChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? sendRequested,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function()? replyArrived,
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
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_SendRequested value) sendRequested,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_ReplyArrived value) replyArrived,
  }) {
    return inputChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_SendRequested value)? sendRequested,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_ReplyArrived value)? replyArrived,
  }) {
    return inputChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_SendRequested value)? sendRequested,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_ReplyArrived value)? replyArrived,
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
abstract class _$$SendRequestedImplCopyWith<$Res> {
  factory _$$SendRequestedImplCopyWith(
    _$SendRequestedImpl value,
    $Res Function(_$SendRequestedImpl) then,
  ) = __$$SendRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$SendRequestedImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$SendRequestedImpl>
    implements _$$SendRequestedImplCopyWith<$Res> {
  __$$SendRequestedImplCopyWithImpl(
    _$SendRequestedImpl _value,
    $Res Function(_$SendRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null}) {
    return _then(
      _$SendRequestedImpl(
        null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SendRequestedImpl implements _SendRequested {
  const _$SendRequestedImpl(this.text);

  @override
  final String text;

  @override
  String toString() {
    return 'ChatEvent.sendRequested(text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendRequestedImpl &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendRequestedImplCopyWith<_$SendRequestedImpl> get copyWith =>
      __$$SendRequestedImplCopyWithImpl<_$SendRequestedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) sendRequested,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function() replyArrived,
  }) {
    return sendRequested(text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? sendRequested,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function()? replyArrived,
  }) {
    return sendRequested?.call(text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? sendRequested,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function()? replyArrived,
    required TResult orElse(),
  }) {
    if (sendRequested != null) {
      return sendRequested(text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_SendRequested value) sendRequested,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_ReplyArrived value) replyArrived,
  }) {
    return sendRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_SendRequested value)? sendRequested,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_ReplyArrived value)? replyArrived,
  }) {
    return sendRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_SendRequested value)? sendRequested,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_ReplyArrived value)? replyArrived,
    required TResult orElse(),
  }) {
    if (sendRequested != null) {
      return sendRequested(this);
    }
    return orElse();
  }
}

abstract class _SendRequested implements ChatEvent {
  const factory _SendRequested(final String text) = _$SendRequestedImpl;

  String get text;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendRequestedImplCopyWith<_$SendRequestedImpl> get copyWith =>
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
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) sendRequested,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function() replyArrived,
  }) {
    return attachmentToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? sendRequested,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function()? replyArrived,
  }) {
    return attachmentToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? sendRequested,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function()? replyArrived,
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
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_SendRequested value) sendRequested,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_ReplyArrived value) replyArrived,
  }) {
    return attachmentToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_SendRequested value)? sendRequested,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_ReplyArrived value)? replyArrived,
  }) {
    return attachmentToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_SendRequested value)? sendRequested,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_ReplyArrived value)? replyArrived,
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
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) sendRequested,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function() replyArrived,
  }) {
    return attachmentClosed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? sendRequested,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function()? replyArrived,
  }) {
    return attachmentClosed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? sendRequested,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function()? replyArrived,
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
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_SendRequested value) sendRequested,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_ReplyArrived value) replyArrived,
  }) {
    return attachmentClosed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_SendRequested value)? sendRequested,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_ReplyArrived value)? replyArrived,
  }) {
    return attachmentClosed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_SendRequested value)? sendRequested,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_ReplyArrived value)? replyArrived,
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
abstract class _$$ReplyArrivedImplCopyWith<$Res> {
  factory _$$ReplyArrivedImplCopyWith(
    _$ReplyArrivedImpl value,
    $Res Function(_$ReplyArrivedImpl) then,
  ) = __$$ReplyArrivedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReplyArrivedImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$ReplyArrivedImpl>
    implements _$$ReplyArrivedImplCopyWith<$Res> {
  __$$ReplyArrivedImplCopyWithImpl(
    _$ReplyArrivedImpl _value,
    $Res Function(_$ReplyArrivedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReplyArrivedImpl implements _ReplyArrived {
  const _$ReplyArrivedImpl();

  @override
  String toString() {
    return 'ChatEvent.replyArrived()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReplyArrivedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) inputChanged,
    required TResult Function(String text) sendRequested,
    required TResult Function() attachmentToggled,
    required TResult Function() attachmentClosed,
    required TResult Function() replyArrived,
  }) {
    return replyArrived();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? inputChanged,
    TResult? Function(String text)? sendRequested,
    TResult? Function()? attachmentToggled,
    TResult? Function()? attachmentClosed,
    TResult? Function()? replyArrived,
  }) {
    return replyArrived?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? inputChanged,
    TResult Function(String text)? sendRequested,
    TResult Function()? attachmentToggled,
    TResult Function()? attachmentClosed,
    TResult Function()? replyArrived,
    required TResult orElse(),
  }) {
    if (replyArrived != null) {
      return replyArrived();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InputChanged value) inputChanged,
    required TResult Function(_SendRequested value) sendRequested,
    required TResult Function(_AttachmentToggled value) attachmentToggled,
    required TResult Function(_AttachmentClosed value) attachmentClosed,
    required TResult Function(_ReplyArrived value) replyArrived,
  }) {
    return replyArrived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InputChanged value)? inputChanged,
    TResult? Function(_SendRequested value)? sendRequested,
    TResult? Function(_AttachmentToggled value)? attachmentToggled,
    TResult? Function(_AttachmentClosed value)? attachmentClosed,
    TResult? Function(_ReplyArrived value)? replyArrived,
  }) {
    return replyArrived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InputChanged value)? inputChanged,
    TResult Function(_SendRequested value)? sendRequested,
    TResult Function(_AttachmentToggled value)? attachmentToggled,
    TResult Function(_AttachmentClosed value)? attachmentClosed,
    TResult Function(_ReplyArrived value)? replyArrived,
    required TResult orElse(),
  }) {
    if (replyArrived != null) {
      return replyArrived(this);
    }
    return orElse();
  }
}

abstract class _ReplyArrived implements ChatEvent {
  const factory _ReplyArrived() = _$ReplyArrivedImpl;
}
