import '../../model/user_model.dart';
import '../../model/match_model.dart';
import '../../model/chat.dart';
import '../../model/message.dart';

abstract class BaseDatabaseRepository {
  Stream<User> getUser(String userId);
  
  Future<List<User>> getAllUsers(String excludeUserId);

  Future<void> createUser(User user);

  Future<void> updateUser(User user);

  Future<void> updateUserPictures(User user, String imageName);

  // Likes
  Future<void> likeUser(String userId, String likedUserId);
  Future<bool> checkIfLiked(String userId, String likedUserId);
  Stream<List<String>> getLikedUsers(String userId);
  Future<List<String>> getLikedUserIds(String userId);
  Stream<List<String>> getUsersWhoLikedMe(String userId);

  // Matches
  Future<Match?> createMatchIfMutual(String userId1, String userId2);
  Stream<List<Match>> getMatches(String userId);
  Future<Match?> getMatch(String userId1, String userId2);

  // Chats
  Future<String> createChat(String userId1, String userId2);
  Stream<Chat> getChat(String chatId);
  Stream<List<Chat>> getUserChats(String userId);
  Future<void> sendMessage(String chatId, Message message);
  Stream<List<Message>> getChatMessages(String chatId);
  Future<void> markMessageAsRead(String chatId, String messageId);
}
