import 'dart:io';

import 'package:dating_app/database/db_repository.dart';
import 'package:dating_app/storage/base_storage_repo.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class StorageRepo extends BaseStorageRepo {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Future<void> uploadImage(XFile image) async {
    try {
      await storage.ref('user_1/${image.name}')
          .putFile(File(image.path))
      .then((p0) => DatabaseRepository().updateUserPictires(image.name));
    } catch (_) {}
  }

  @override
  Future<String> getDownloadUrl(String imageName) async {
    String downloadUrl = await storage.ref('user_1/$imageName')
        .getDownloadURL();

    return downloadUrl;
  }
}
