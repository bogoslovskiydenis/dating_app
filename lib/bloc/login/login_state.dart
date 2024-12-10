part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final User user;

  const LoginLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});

  @override
  List<Object?> get props => [message];
}