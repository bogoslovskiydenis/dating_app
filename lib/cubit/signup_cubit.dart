import 'package:bloc/bloc.dart';
import 'package:dating_app/repository/auth/auth_repo.dart';
import 'package:dating_app/screens/login_screen/login_screens/start_screen.dart';
import 'package:equatable/equatable.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepo _authRepo;

  SignupCubit({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(SignupState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  void signupCredential() async {
    if(!state.isValid)return;
    try {
      await _authRepo.sighUp(email: state.email, password: state.password);
      emit(state.copyWith(status: SignupStatus.success));
    } catch (_) {}
  }
}
