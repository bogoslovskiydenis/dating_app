import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Message extends Equatable {
  final String? id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime dateTime;
  final String timeString;
  final bool isRead;

  const Message({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
    required this.timeString,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [
    id,
    senderId,
    receiverId,
    message,
    dateTime,
    timeString,
    isRead,
  ];

  factory Message.fromDocument(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final timestamp = (data['timestamp'] as Timestamp).toDate();
    return Message(
      id: snapshot.id,
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      message: data['message'] ?? '',
      dateTime: timestamp,
      timeString: DateFormat('jm').format(timestamp),
      isRead: data['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': Timestamp.fromDate(dateTime),
      'isRead': isRead,
    };
  }

  Message copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? message,
    DateTime? dateTime,
    String? timeString,
    bool? isRead,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      dateTime: dateTime ?? this.dateTime,
      timeString: timeString ?? this.timeString,
      isRead: isRead ?? this.isRead,
    );
  }
}