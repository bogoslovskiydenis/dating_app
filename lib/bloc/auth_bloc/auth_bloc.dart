import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dating_app/model/models.dart';
import 'package:dating_app/repository/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  StreamSubscription<auth.User?>? _userSubscription;

  AuthBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(AuthState.unknown()
      ) {
    _userSubscription = _authRepo.user.listen((user) {
      add(AuthUserChanged(user: user!));
    });
    on<AuthEvent>((event, emit) async {
      if (event is AuthUserChanged) {
        AuthState.authenticated(user: event.user);
      }
    });
  }

  @override
  Future<void> close(){
    _userSubscription?.cancel();
    return super.close();
  }
}

