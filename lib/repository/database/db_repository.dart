import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/models.dart';
import '../repositories.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String id) {
    return _firebaseFirestore
        .collection('users')
        .doc(id)
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
  Future<String> createUser(User user) async {
    String docId = await _firebaseFirestore
        .collection('users')
        .add(user.toMap())
        .then((value) {
      print('User add, id: ${value.id}');
      return value.id;
    });
    return docId;
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
