part of 'swipe_bloc.dart';

@immutable
abstract class SwipeState extends Equatable {
  const SwipeState();

  @override
  List<Object?> get props => [];
}

class SwipeLoading extends SwipeState {}

class SwipeLoaded extends SwipeState {
  final List<User> users;

  const SwipeLoaded({required this.users});
  @override
  List<Object?> get props => [users];
}

class SwipeMatchCreated extends SwipeState {
  final Match match;
  final List<User> users;

  const SwipeMatchCreated({required this.match, required this.users});
  @override
  List<Object?> get props => [match, users];
}

class SwipeError extends SwipeState {}

