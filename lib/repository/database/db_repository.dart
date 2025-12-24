import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/models.dart';
import '../repositories.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    print('Getting user data for ID: $userId');
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        throw Exception('User not found');
      }
      print('Retrieved user data: ${snapshot.data()}');
      return User.fromDocument(snapshot);
    });
  }

  @override
  Future<List<User>> getAllUsers(String excludeUserId) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection('users')
          .where(FieldPath.documentId, isNotEqualTo: excludeUserId)
          .get();
      
      final users = snapshot.docs
          .map((doc) => User.fromDocument(doc))
          .where((user) => user.imageUrls.isNotEmpty)
          .toList();
      
      print('Loaded ${users.length} users from Firestore');
      return users;
    } catch (e) {
      print('Error loading users: $e');
      return [];
    }
  }

  @override
  Future<void> updateUserPictires(User user, String imageName) async {
    String downloadUrl = await StorageRepo().getDownloadUrl(user, imageName);
    return _firebaseFirestore.collection('users').doc(user.id).update({
      'imageUrls': FieldValue.arrayUnion([downloadUrl])
    });
  }

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .set(user.toMap())
        .then((value) {
      print('User document created');
    }).catchError((error) {
      print('Error creating user: $error');
      throw error;
    });
  }

  @override
  Future<void> updateUser(User user) {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update({
      'name': user.name,
      'age': user.age,
      'gender': user.gender,
      'location': user.location,
      'bio': user.bio,
      'jobTitle': user.jobTitle,
      'interests': user.interests,
      'imageUrls': user.imageUrls,
    })
        .then((value) => print('User data updated with all fields'));
  }

  @override
  Future<void> updateUserPictures(User user, String newImageUrl) async {
    List<String> updatedUrls = [...user.imageUrls, newImageUrl];
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update({
      'imageUrls': updatedUrls,
    });
  }

  // Likes
  @override
  Future<void> likeUser(String userId, String likedUserId) async {
    await _firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('likes')
        .doc(likedUserId)
        .set({'likedAt': FieldValue.serverTimestamp()});
  }

  @override
  Future<bool> checkIfLiked(String userId, String likedUserId) async {
    final doc = await _firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('likes')
        .doc(likedUserId)
        .get();
    return doc.exists;
  }

  @override
  Stream<List<String>> getLikedUsers(String userId) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('likes')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  Future<List<String>> getLikedUsersSync(String userId) async {
    final snapshot = await _firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('likes')
        .get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }
  
  Future<List<String>> getLikedUserIds(String userId) async {
    final snapshot = await _firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('likes')
        .get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }

  @override
  Stream<List<String>> getUsersWhoLikedMe(String userId) {
    return _firebaseFirestore
        .collectionGroup('likes')
        .where(FieldPath.documentId, isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      final userIds = <String>[];
      for (final doc in snapshot.docs) {
        final parentId = doc.reference.parent.parent?.id;
        if (parentId != null && parentId.isNotEmpty) {
          userIds.add(parentId);
        }
      }
      return userIds;
    });
  }

  // Matches
  @override
  Future<Match?> createMatchIfMutual(String userId1, String userId2) async {
    final liked1 = await checkIfLiked(userId1, userId2);
    final liked2 = await checkIfLiked(userId2, userId1);

    if (liked1 && liked2) {
      final existingMatch = await getMatch(userId1, userId2);
      if (existingMatch != null) {
        return existingMatch;
      }

      final chatId = await createChat(userId1, userId2);
      final matchRef = _firebaseFirestore.collection('matches').doc();
      final match = Match(
        id: matchRef.id,
        userId1: userId1,
        userId2: userId2,
        createdAt: DateTime.now(),
        chatId: chatId,
      );

      await matchRef.set(match.toMap());
      return match;
    }

    return null;
  }

  @override
  Stream<List<Match>> getMatches(String userId) {
    try {
      return _firebaseFirestore
          .collection('matches')
          .where('userId1', isEqualTo: userId)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Match.fromDocument(doc)).toList())
          .asyncMap((matches1) async {
        try {
          final matches2 = await _firebaseFirestore
              .collection('matches')
              .where('userId2', isEqualTo: userId)
              .get();
          final matches2List =
              matches2.docs.map((doc) => Match.fromDocument(doc)).toList();
          return [...matches1, ...matches2List];
        } catch (e) {
          print('Error loading matches2: $e');
          return matches1;
        }
      }).handleError((error) {
        print('Error in getMatches stream: $error');
        throw error;
      });
    } catch (e) {
      print('Error setting up getMatches stream: $e');
      return Stream.value([]);
    }
  }

  @override
  Future<Match?> getMatch(String userId1, String userId2) async {
    final match1 = await _firebaseFirestore
        .collection('matches')
        .where('userId1', isEqualTo: userId1)
        .where('userId2', isEqualTo: userId2)
        .limit(1)
        .get();

    if (match1.docs.isNotEmpty) {
      return Match.fromDocument(match1.docs.first);
    }

    final match2 = await _firebaseFirestore
        .collection('matches')
        .where('userId1', isEqualTo: userId2)
        .where('userId2', isEqualTo: userId1)
        .limit(1)
        .get();

    if (match2.docs.isNotEmpty) {
      return Match.fromDocument(match2.docs.first);
    }

    return null;
  }

  // Chats
  @override
  Future<String> createChat(String userId1, String userId2) async {
    final chatRef = _firebaseFirestore.collection('chats').doc();
    final chat = Chat(
      id: chatRef.id,
      userId1: userId1,
      userId2: userId2,
    );
    await chatRef.set(chat.toMap());
    return chatRef.id;
  }

  @override
  Stream<Chat> getChat(String chatId) {
    return _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .snapshots()
        .map((snapshot) => Chat.fromDocument(snapshot));
  }

  @override
  Stream<List<Chat>> getUserChats(String userId) {
    return _firebaseFirestore
        .collection('chats')
        .where('userId1', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Chat.fromDocument(doc)).toList())
        .asyncMap((chats1) async {
      final chats2 = await _firebaseFirestore
          .collection('chats')
          .where('userId2', isEqualTo: userId)
          .get();
      final chats2List =
          chats2.docs.map((doc) => Chat.fromDocument(doc)).toList();
      return [...chats1, ...chats2List];
    });
  }

  @override
  Future<void> sendMessage(String chatId, Message message) async {
    final messagesRef =
        _firebaseFirestore.collection('chats').doc(chatId).collection('messages');
    await messagesRef.add(message.toMap());

    await _firebaseFirestore.collection('chats').doc(chatId).update({
      'lastMessage': message.message,
      'lastMessageTime': Timestamp.fromDate(message.dateTime),
    });
  }

  @override
  Stream<List<Message>> getChatMessages(String chatId) {
    return _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromDocument(doc)).toList());
  }

  @override
  Future<void> markMessageAsRead(String chatId, String messageId) async {
    await _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({'isRead': true});
  }
}
