import 'package:equatable/equatable.dart';

import '../../model/user_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  const ProfileLoaded({required this.user});
  @override
  List<Object?> get props => [user];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError({required this.message});
  @override
  List<Object?> get props => [message];
}