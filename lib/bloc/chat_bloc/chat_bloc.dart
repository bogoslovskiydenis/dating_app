import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dating_app/model/message.dart';
import 'package:dating_app/repository/database/db_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final DatabaseRepository _databaseRepository;
  final String currentUserId;

  ChatBloc({
    required DatabaseRepository databaseRepository,
    required this.currentUserId,
  })  : _databaseRepository = databaseRepository,
        super(ChatInitial()) {
    on<LoadChatMessages>(_onLoadChatMessages);
    on<SendMessage>(_onSendMessage);
    on<MarkMessageAsRead>(_onMarkMessageAsRead);
  }

  void _onLoadChatMessages(
    LoadChatMessages event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    
    await emit.forEach<List<Message>>(
      _databaseRepository.getChatMessages(event.chatId),
      onData: (messages) => ChatLoaded(messages: messages),
      onError: (error, stackTrace) => ChatError(message: error.toString()),
    );
  }

  void _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (event.message.trim().isEmpty) return;

    final message = Message(
      senderId: currentUserId,
      receiverId: event.receiverId,
      message: event.message,
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(DateTime.now()),
      isRead: false,
    );

    try {
      await _databaseRepository.sendMessage(event.chatId, message);
    } catch (e) {
      emit(ChatError(message: 'Failed to send message: $e'));
    }
  }

  void _onMarkMessageAsRead(
    MarkMessageAsRead event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _databaseRepository.markMessageAsRead(
        event.chatId,
        event.messageId,
      );
    } catch (e) {
      emit(ChatError(message: 'Failed to mark message as read: $e'));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

