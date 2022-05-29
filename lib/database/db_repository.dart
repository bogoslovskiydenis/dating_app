import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/database/base_db_repository.dart';
import 'package:dating_app/model/user_model.dart';
import 'package:dating_app/storage/storage_repository.dart';

class DatabaseRepository extends BaseDatabaseRepository{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser() {
   return _firebaseFirestore.collection('users')
       .doc('W1vA0ovppxf50VOClOOF')
       .snapshots()
       .map((snapshot) => User.fromSnapshot(snapshot));
  }

  @override
  Future<void> updateUserPictires(String imageName)  async {
    String downloadUrl = await StorageRepo().getDownloadUrl(imageName);
    return _firebaseFirestore.collection('users')
        .doc('W1vA0ovppxf50VOClOOF')
        .update({'imageUrls': FieldValue.arrayUnion([downloadUrl])});
  }
}