import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dating_app/repository/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/user_model.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DatabaseRepository _databaseRepository;
  final StorageRepo _storageRepo;
  StreamSubscription<User>? _userSubscription;

  LoginBloc(
      {required DatabaseRepository databaseRepository,
      required StorageRepo storageRepo})
      : _databaseRepository = databaseRepository,
        _storageRepo = storageRepo,
        super(LoginLoading()) {
    on<StartLogin>(_onStartLogin);
    on<UpdateUserLogin>(_onUpdateUserLogin);
    on<UpdateUserImages>(_onUpdateuserImages);
  }

  void _onStartLogin(StartLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await _databaseRepository.createUser(event.user);
      emit(LoginLoaded(user: event.user));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  void _onUpdateUserLogin(
      UpdateUserLogin event, Emitter<LoginState> emit) async {
    if (state is LoginLoaded) {
      if (event.user.id != null) {
        await _databaseRepository.updateUser(event.user);
      }
      emit(LoginLoaded(user: event.user));
    }
  }

  void _onUpdateuserImages(
      UpdateUserImages event, Emitter<LoginState> emit) async {
    if (state is LoginLoaded) {
      User user = (state as LoginLoaded).user;
      if (user.id == null) return;

      try {
        await _storageRepo.uploadImage(user, event.image);
        
        _userSubscription?.cancel();
        _userSubscription = _databaseRepository.getUser(user.id!).listen(
          (updatedUser) {
            if (updatedUser.imageUrls.isNotEmpty) {
              add(UpdateUserLogin(user: updatedUser));
              _userSubscription?.cancel();
            }
          },
        );
      } catch (e) {
        print('Error uploading image: $e');
        emit(LoginError(message: 'Failed to upload image: $e'));
      }
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
