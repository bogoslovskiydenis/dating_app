part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class StartLogin extends LoginEvent {
  final User? user;

  StartLogin(
      {this.user = const User(
        id: '',
        name: '',
        age: 0,
        gender: '',
        imageUrls: [],
        jobTitle: '',
        bio: '',
        location: '',
        interests: [],
      )});

  @override
  List<Object?> get props => [user];
}

class UpdateUserLogin extends LoginEvent {
  final User user;

  const UpdateUserLogin({required this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateUserImages extends LoginEvent {
  final User? user;
  final XFile image;

  const UpdateUserImages({required this.image, this.user});

  @override
  List<Object?> get props => [user, image];
}
