part of 'registration_cubit.dart';


enum RegistrationStatus { initial, submitting, success, error }

class RegistrationState extends Equatable {
  final String email;
  final String password;
  final RegistrationStatus status;
  final auth.User? user;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  const RegistrationState({
    required this.email,
    required this.password,
    required this.status,
    this.user,
  });

  factory RegistrationState.initial() {
    return const RegistrationState(
        email: '',
        password: '',
        status: RegistrationStatus.initial,
        user: null);
  }

  @override
  List<Object?> get props => [email, password, status, user];

  RegistrationState copyWith({
    String? email,
    String? password,
    RegistrationStatus? status,
    auth.User? user,
  }) {
    return RegistrationState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        user: user ?? this.user);
  }
}
