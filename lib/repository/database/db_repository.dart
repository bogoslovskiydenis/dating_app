import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/models.dart';
import '../repositories.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => User.fromDocument(snapshot));
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
    await _firebaseFirestore.collection('users').doc(user.id).set(user.toMap());
  }

  @override
  Future<void> updateUser(User user) {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toMap())
        .then((value) {
      print('User document update!');
    });
  }
}
