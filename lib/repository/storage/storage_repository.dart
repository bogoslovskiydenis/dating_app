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
      await storage
          .ref('user_1/${image.name}')
          .putFile(File(image.path))
          .then((p0) =>
              DatabaseRepository().updateUserPictires(user, image.name));
    } catch (_) {}
  }

  @override
  Future<String> getDownloadUrl(User user, String imageName) async {
    String downloadUrl =
        await storage.ref('user_1/$imageName').getDownloadURL();

    return downloadUrl;
  }
}
