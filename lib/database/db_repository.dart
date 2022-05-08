
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/database/base_db_repository.dart';
import 'package:dating_app/model/user_model.dart';
import 'package:dating_app/storage/storage_repository.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseRepository extends BaseDatabaseRepository{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser() {
   return _firebaseFirestore.collection('users')
       .doc('Q6tnVBD0QBiEwScUFXyY')
       .snapshots()
       .map((snapshot) => User.fromSnapshot(snapshot));
  }

  @override
  Future<void> updateUserPictires(String imageName)  async {
    String downloadUrl = await StorageRepo().getDownloadUrl(imageName);
    return _firebaseFirestore.collection('users')
        .doc('Q6tnVBD0QBiEwScUFXyY')
        .update({'imageUrls': FieldValue.arrayUnion([downloadUrl])});
  }
}