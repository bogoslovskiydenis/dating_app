import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Message extends Equatable {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  final DateTime dateTime;
  final String timeString;

  Message({required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
    required this.timeString});

  @override
  List<Object?> get props =>
      [id, senderId, receiverId, message, dateTime, timeString];

  static List<Message> messages = [Message(
      id: 1,
      senderId: 1,
      receiverId: 2,
      message: "Message",
      dateTime: DateTime.now(),
  timeString: DateFormat('ru').format(DateTime.now())),];
}
