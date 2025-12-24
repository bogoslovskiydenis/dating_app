import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import '../../model/models.dart';
import '../repositories.dart';

class StorageRepo extends BaseStorageRepo {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Future<void> uploadImage(User user, XFile image) async {
    try {
      if (user.id == null) return;
      await storage
          .ref('${user.id}/${image.name}')
          .putFile(File(image.path))
          .then((p0) =>
              DatabaseRepository().updateUserPictires(user, image.name));
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Future<String> getDownloadUrl(User user, String imageName) async {
    if (user.id == null) throw Exception('User ID is null');
    String downloadUrl =
        await storage.ref('${user.id}/$imageName').getDownloadURL();

    return downloadUrl;
  }
}
