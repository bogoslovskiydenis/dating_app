import '../../model/user_model.dart';

abstract class BaseDatabaseRepository {
  Stream<User> getUser(String userId);

  Future<void> createUser(User user);

  Future<void> updateUser(User user);

  Future<void> updateUserPictires(User user, String imageName);
}
