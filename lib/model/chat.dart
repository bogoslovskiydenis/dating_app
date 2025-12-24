import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'message.dart';

class Chat extends Equatable {
  final String id;
  final String userId1;
  final String userId2;
  final List<Message>? messages;
  final DateTime? lastMessageTime;
  final String? lastMessage;

  const Chat({
    required this.id,
    required this.userId1,
    required this.userId2,
    this.messages,
    this.lastMessageTime,
    this.lastMessage,
  });

  @override
  List<Object?> get props => [id, userId1, userId2, messages, lastMessageTime, lastMessage];

  factory Chat.fromDocument(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Chat(
      id: snapshot.id,
      userId1: data['userId1'] ?? '',
      userId2: data['userId2'] ?? '',
      lastMessageTime: data['lastMessageTime'] != null
          ? (data['lastMessageTime'] as Timestamp).toDate()
          : null,
      lastMessage: data['lastMessage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId1': userId1,
      'userId2': userId2,
      'lastMessageTime': lastMessageTime != null
          ? Timestamp.fromDate(lastMessageTime!)
          : null,
      'lastMessage': lastMessage,
    };
  }
}