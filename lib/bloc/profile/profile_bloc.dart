import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dating_app/bloc/blocks.dart';
import 'package:dating_app/bloc/profile/profile_state.dart';
import 'package:equatable/equatable.dart';

import '../../model/user_model.dart';
import '../../repository/database/db_repository.dart';

part 'profile_event.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBLoc;
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _subscription;

  ProfileBloc({required AuthBloc authBloc,
    required DatabaseRepository databaseRepository})
      : _authBLoc = authBloc,
        _databaseRepository = databaseRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProile);
    on<UpdateProfile>(_onUpdateProfile);

    _subscription = _authBLoc.stream.listen((state) {
      if (state.user != null) {
        add(LoadProfile(userId: state.user!.uid));
      }
    });
  }

  void _onLoadProile(LoadProfile event, Emitter<ProfileState> emit) {
    print('Loading profile for user: ${event.userId}');
    if (event.userId.isEmpty) {
      emit(ProfileLoading());
      return;
    }

    _databaseRepository.getUser(event.userId).listen(
            (user) {
          print('Profile loaded: ${user.name}');
          add(UpdateProfile(user: user));
        },
        onError: (error) {
          print('Error loading profile: $error');
          emit(ProfileError(message: error.toString()));
        }
    );
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) {
    print('Updating profile for user: ${event.user.id}');
    try {
      emit(ProfileLoaded(user: event.user));
    } catch (e) {
      print('Error updating profile state: $e');
      emit(ProfileError(message: e.toString()));
    }
  }
}
