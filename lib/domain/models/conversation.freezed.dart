// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Conversation {
  String get id => throw _privateConstructorUsedError;
  List<String> get participantIds => throw _privateConstructorUsedError;
  Map<String, ConversationParticipant> get participants =>
      throw _privateConstructorUsedError;
  String get lastMessage => throw _privateConstructorUsedError;
  DateTime get lastMessageTime => throw _privateConstructorUsedError;
  String get lastMessageSenderId => throw _privateConstructorUsedError;
  Map<String, int> get unreadCounts => throw _privateConstructorUsedError;
  ChatSource get chatSource => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
    Conversation value,
    $Res Function(Conversation) then,
  ) = _$ConversationCopyWithImpl<$Res, Conversation>;
  @useResult
  $Res call({
    String id,
    List<String> participantIds,
    Map<String, ConversationParticipant> participants,
    String lastMessage,
    DateTime lastMessageTime,
    String lastMessageSenderId,
    Map<String, int> unreadCounts,
    ChatSource chatSource,
    DateTime createdAt,
  });

  $ChatSourceCopyWith<$Res> get chatSource;
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res, $Val extends Conversation>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? participantIds = null,
    Object? participants = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? lastMessageSenderId = null,
    Object? unreadCounts = null,
    Object? chatSource = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            participantIds: null == participantIds
                ? _value.participantIds
                : participantIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            participants: null == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as Map<String, ConversationParticipant>,
            lastMessage: null == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            lastMessageTime: null == lastMessageTime
                ? _value.lastMessageTime
                : lastMessageTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastMessageSenderId: null == lastMessageSenderId
                ? _value.lastMessageSenderId
                : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
                      as String,
            unreadCounts: null == unreadCounts
                ? _value.unreadCounts
                : unreadCounts // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            chatSource: null == chatSource
                ? _value.chatSource
                : chatSource // ignore: cast_nullable_to_non_nullable
                      as ChatSource,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatSourceCopyWith<$Res> get chatSource {
    return $ChatSourceCopyWith<$Res>(_value.chatSource, (value) {
      return _then(_value.copyWith(chatSource: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConversationImplCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$ConversationImplCopyWith(
    _$ConversationImpl value,
    $Res Function(_$ConversationImpl) then,
  ) = __$$ConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    List<String> participantIds,
    Map<String, ConversationParticipant> participants,
    String lastMessage,
    DateTime lastMessageTime,
    String lastMessageSenderId,
    Map<String, int> unreadCounts,
    ChatSource chatSource,
    DateTime createdAt,
  });

  @override
  $ChatSourceCopyWith<$Res> get chatSource;
}

/// @nodoc
class __$$ConversationImplCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res, _$ConversationImpl>
    implements _$$ConversationImplCopyWith<$Res> {
  __$$ConversationImplCopyWithImpl(
    _$ConversationImpl _value,
    $Res Function(_$ConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? participantIds = null,
    Object? participants = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? lastMessageSenderId = null,
    Object? unreadCounts = null,
    Object? chatSource = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ConversationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        participantIds: null == participantIds
            ? _value._participantIds
            : participantIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        participants: null == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as Map<String, ConversationParticipant>,
        lastMessage: null == lastMessage
            ? _value.lastMessage
            : lastMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        lastMessageTime: null == lastMessageTime
            ? _value.lastMessageTime
            : lastMessageTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastMessageSenderId: null == lastMessageSenderId
            ? _value.lastMessageSenderId
            : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
                  as String,
        unreadCounts: null == unreadCounts
            ? _value._unreadCounts
            : unreadCounts // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        chatSource: null == chatSource
            ? _value.chatSource
            : chatSource // ignore: cast_nullable_to_non_nullable
                  as ChatSource,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$ConversationImpl implements _Conversation {
  const _$ConversationImpl({
    required this.id,
    required final List<String> participantIds,
    required final Map<String, ConversationParticipant> participants,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageSenderId,
    required final Map<String, int> unreadCounts,
    required this.chatSource,
    required this.createdAt,
  }) : _participantIds = participantIds,
       _participants = participants,
       _unreadCounts = unreadCounts;

  @override
  final String id;
  final List<String> _participantIds;
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  final Map<String, ConversationParticipant> _participants;
  @override
  Map<String, ConversationParticipant> get participants {
    if (_participants is EqualUnmodifiableMapView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_participants);
  }

  @override
  final String lastMessage;
  @override
  final DateTime lastMessageTime;
  @override
  final String lastMessageSenderId;
  final Map<String, int> _unreadCounts;
  @override
  Map<String, int> get unreadCounts {
    if (_unreadCounts is EqualUnmodifiableMapView) return _unreadCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_unreadCounts);
  }

  @override
  final ChatSource chatSource;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Conversation(id: $id, participantIds: $participantIds, participants: $participants, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, lastMessageSenderId: $lastMessageSenderId, unreadCounts: $unreadCounts, chatSource: $chatSource, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(
              other._participantIds,
              _participantIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime) &&
            (identical(other.lastMessageSenderId, lastMessageSenderId) ||
                other.lastMessageSenderId == lastMessageSenderId) &&
            const DeepCollectionEquality().equals(
              other._unreadCounts,
              _unreadCounts,
            ) &&
            (identical(other.chatSource, chatSource) ||
                other.chatSource == chatSource) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_participantIds),
    const DeepCollectionEquality().hash(_participants),
    lastMessage,
    lastMessageTime,
    lastMessageSenderId,
    const DeepCollectionEquality().hash(_unreadCounts),
    chatSource,
    createdAt,
  );

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      __$$ConversationImplCopyWithImpl<_$ConversationImpl>(this, _$identity);
}

abstract class _Conversation implements Conversation {
  const factory _Conversation({
    required final String id,
    required final List<String> participantIds,
    required final Map<String, ConversationParticipant> participants,
    required final String lastMessage,
    required final DateTime lastMessageTime,
    required final String lastMessageSenderId,
    required final Map<String, int> unreadCounts,
    required final ChatSource chatSource,
    required final DateTime createdAt,
  }) = _$ConversationImpl;

  @override
  String get id;
  @override
  List<String> get participantIds;
  @override
  Map<String, ConversationParticipant> get participants;
  @override
  String get lastMessage;
  @override
  DateTime get lastMessageTime;
  @override
  String get lastMessageSenderId;
  @override
  Map<String, int> get unreadCounts;
  @override
  ChatSource get chatSource;
  @override
  DateTime get createdAt;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
