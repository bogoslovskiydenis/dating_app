import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/models.dart';
import '../repositories.dart';

class DatabaseRepository extends BaseDatabaseRepository{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser() {
   return _firebaseFirestore.collection('users')
       .doc('jw2AHi7G115w3mFjaMe4')
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