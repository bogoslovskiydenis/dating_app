part of 'auth_bloc.dart';
enum AuthStatus{unknown, authenticated, unauthenticated}
@immutable
 class AuthState extends Equatable{
  final AuthStatus status;
  final auth.User? user;
  const AuthState({this.status = AuthStatus.unknown, this.user});
  const AuthState.unknown() : this();
  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);
  const AuthState.authenticated({required auth.User user}) : this(status: AuthStatus.authenticated, user: user);

  @override
  List<Object?> get props => [status , user];
}
