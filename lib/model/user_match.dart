import 'package:dating_app/model/user_model.dart';
import 'package:equatable/equatable.dart';

class UserMarch extends Equatable {
  final int id;
  final int userId;
  final User matchedUser;


  const UserMarch(
      {required this.id, required this.userId, required this.matchedUser});

  @override
  List<Object?> get props => [id, userId, matchedUser];

  static List<UserMarch> matches = [
    UserMarch(id: 1, matchedUser: User.users[1], userId: 1 )
  ];
}
