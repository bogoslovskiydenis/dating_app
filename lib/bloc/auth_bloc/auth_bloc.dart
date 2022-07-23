import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dating_app/repository/auth/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  StreamSubscription<auth.User?>? _userSubscription;

  AuthBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const AuthState.unknown()) {
    _userSubscription = _authRepo.user.listen((user) {
      add(AuthUserChanged(user: user));
    });
    on<AuthUserChanged>((AuthUserChanged event, Emitter<AuthState> emit) {
      event.user != null
          ? emit(AuthState.authenticated(user: event.user!))
          : emit(const AuthState.unauthenticated());
    });
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
