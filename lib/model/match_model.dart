import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Match extends Equatable {
  final String id;
  final String userId1;
  final String userId2;
  final DateTime createdAt;
  final String chatId;

  const Match({
    required this.id,
    required this.userId1,
    required this.userId2,
    required this.createdAt,
    required this.chatId,
  });

  @override
  List<Object?> get props => [id, userId1, userId2, createdAt, chatId];

  factory Match.fromDocument(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Match(
      id: snapshot.id,
      userId1: data['userId1'] ?? '',
      userId2: data['userId2'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      chatId: data['chatId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId1': userId1,
      'userId2': userId2,
      'createdAt': Timestamp.fromDate(createdAt),
      'chatId': chatId,
    };
  }
}

