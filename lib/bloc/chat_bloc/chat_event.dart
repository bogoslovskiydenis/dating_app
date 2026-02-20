part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadChatMessages extends ChatEvent {
  final String chatId;

  const LoadChatMessages({required this.chatId});

  @override
  List<Object?> get props => [chatId];
}

class SendMessage extends ChatEvent {
  final String chatId;
  final String receiverId;
  final String message;

  const SendMessage({
    required this.chatId,
    required this.receiverId,
    required this.message,
  });

  @override
  List<Object?> get props => [chatId, receiverId, message];
}

class MarkMessageAsRead extends ChatEvent {
  final String chatId;
  final String messageId;

  const MarkMessageAsRead({
    required this.chatId,
    required this.messageId,
  });

  @override
  List<Object?> get props => [chatId, messageId];
}

class ChatMessagesUpdated extends ChatEvent {
  final List<Message> messages;

  const ChatMessagesUpdated({required this.messages});

  @override
  List<Object?> get props => [messages];
}


