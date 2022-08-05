import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dating_app/bloc/blocks.dart';
import 'package:equatable/equatable.dart';

import '../../model/user_model.dart';
import '../../repository/database/db_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

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

  void _onLoadProile(LoadProfile event, Emitter<ProfileState> emitter) {
    print(event.userId);
    _databaseRepository.getUser(event.userId).listen((user) {
      add(UpdateProfile(user: user));
    });
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emitter) {
    print(event.user);
    emitter(ProfileLoaded(user: event.user));
  }

  @override
  Future<void>close()async{
    _subscription?.cancel();
    super.close();
  }
}
