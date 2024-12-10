part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final SignupStatus status;
  final auth.User? user;
  final String? errorMessage;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  const SignupState({
    required this.email,
    required this.password,
    required this.status,
    this.user,
    this.errorMessage,
  });

  factory SignupState.initial() {
    return const SignupState(
      email: '',
      password: '',
      status: SignupStatus.initial,
      user: null,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [email, password, status, user, errorMessage];

  SignupState copyWith({
    String? email,
    String? password,
    SignupStatus? status,
    auth.User? user,
    String? errorMessage,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}
