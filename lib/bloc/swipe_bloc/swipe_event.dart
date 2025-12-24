part of 'swipe_bloc.dart';

@immutable
abstract class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends SwipeEvent {
  final List<User>? users;
  final String? currentUserId;

  const LoadUsers({this.users, this.currentUserId});

  @override
  List<Object?> get props => [users, currentUserId];
}

class SwipeLeftEvent extends SwipeEvent {
  final User user;

  const SwipeLeftEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class SwipeRightEvent extends SwipeEvent {
  final User user;
  final String? currentUserId;

  const SwipeRightEvent({
    required this.user,
    this.currentUserId,
  });

  @override
  List<Object?> get props => [user, currentUserId];
}

