import 'package:blood_setu/domain/models/chat_source.dart';
import 'package:blood_setu/domain/models/conversation.dart';
import 'package:blood_setu/domain/models/message.dart';
import 'package:blood_setu/domain/models/message_type.dart';
import 'package:blood_setu/domain/models/presence_status.dart';
import 'package:blood_setu/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures/failures.dart';

@injectable
class ChatUseCase {
  final IChatRepository _repository;

  ChatUseCase(this._repository);

  Future<Either<Failure, Conversation>> getOrCreateConversation({
    required String currentUid,
    required String otherUid,
    required ChatSource chatSource,
  }) async {
    try {
      final conv = await _repository.getOrCreateConversation(
        currentUid: currentUid,
        otherUid: otherUid,
        chatSource: chatSource,
      );
      return Right(conv);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  Stream<List<Conversation>> watchConversations(String uid) =>
      _repository.watchConversations(uid);

  Stream<List<Message>> watchMessages(String conversationId) =>
      _repository.watchMessages(conversationId);

  Future<Either<Failure, void>> sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
    required MessageType type,
  }) async {
    try {
      await _repository.sendMessage(
        conversationId: conversationId,
        senderId: senderId,
        text: text,
        type: type,
      );
      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> markAsRead({
    required String conversationId,
    required String uid,
  }) async {
    try {
      await _repository.markAsRead(conversationId: conversationId, uid: uid);
      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> setOnlineStatus(
    String uid,
    bool online,
  ) async {
    try {
      await _repository.setOnlineStatus(uid, online);
      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  Stream<PresenceStatus> watchPresence(String uid) =>
      _repository.watchPresence(uid);
}
