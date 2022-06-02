import 'package:dating_app/model/models.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseStorageRepo {
  Future<void> uploadImage(User user, XFile image);

  Future<String> getDownloadUrl(User user, String imageName);
}
