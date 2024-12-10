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
      'bio': user.bio,
      'location': user.location,
      'interests': user.interests,
      'imageUrls': user.imageUrls,
    })
        .then((value) => print('User data updated'));
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
}
