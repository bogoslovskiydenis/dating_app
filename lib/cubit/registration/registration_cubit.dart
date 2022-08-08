import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../repository/auth/auth_repo.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final AuthRepo _authRepo;

  RegistrationCubit({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(RegistrationState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: RegistrationStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: RegistrationStatus.initial));
  }

  Future<void> logInWithCredentials() async {
    if (state.status == RegistrationStatus.submitting) return;
    emit(state.copyWith(status: RegistrationStatus.submitting));
    try {
      await _authRepo.logInWithEmailAndPassword(
          email: state.email, password: state.password);
      emit(state.copyWith(status: RegistrationStatus.success));
    } catch (_) {}
  }
}
