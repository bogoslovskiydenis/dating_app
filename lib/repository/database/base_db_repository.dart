import '../../model/user_model.dart';

abstract class BaseDatabaseRepository {
  Stream<User> getUser();

  Future<void> updateUserPictires(String imageName);
}
