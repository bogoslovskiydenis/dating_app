import 'package:bloc/bloc.dart';
import 'package:dating_app/model/user_model.dart';
import 'package:dating_app/repository/auth/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepo _authRepo;
  final auth.User? user;

  SignupCubit({this.user, required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(SignupState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

 Future<void> signupCredential() async {

    if(!state.isFormValid || state.status == SignupStatus.submitting) {
      emit(state.copyWith(status: SignupStatus.submitting));
    }
    try {
      await _authRepo.sighUp(email: state.email, password: state.password);
      emit(state.copyWith(status: SignupStatus.success , user: user));
    } catch (_) {}
  }
}
