import 'package:dating_app/model/chat.dart';
import 'package:dating_app/model/user_model.dart';
import 'package:equatable/equatable.dart';

class UserMarch extends Equatable {
  final int id;
  final int userId;
  final User matchedUser;
  final List<Chat> chat;

  const UserMarch(
      {required this.chat,
      required this.id,
      required this.userId,
      required this.matchedUser});

  @override
  List<Object?> get props => [id, userId, matchedUser, chat];

  static List<UserMarch> matches = [
    UserMarch(
        id: 1,
        matchedUser: User.users[1],
        userId: 1,
        chat: Chat.chats
            .where((chat) => chat.userId == 1 && chat.matchedUserId == 2)
            .toList())
  ];
}
