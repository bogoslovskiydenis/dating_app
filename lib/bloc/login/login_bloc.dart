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
    User user = const User(
      id: '',
      age: 0,
      location: '',
      name: '',
      gender: '',
      bio: '',
      jobTitle: '',
      imageUrls: [],
      interests: [],
    );

    String docId = await _databaseRepository.createUser(user);
    emit(
      LoginLoaded(
        user: user.copyWith(id: docId),
      ),
    );
  }

  void _onUpdateUserLogin(
      UpdateUserLogin event, Emitter<LoginState> emit) async {
    if (state is LoginLoaded) {
      _databaseRepository.updateUser(event.user);
      emit(
        LoginLoaded(user: event.user),
      );
    }
  }

  void _onUpdateuserImages(
      UpdateUserImages event, Emitter<LoginState> emit) async {
    if (state is LoginLoaded) {
      User user = (state as LoginLoaded).user;
      await _storageRepo.uploadImage(user, event.image);

      _databaseRepository.getUser(user.id!).listen(
        (event) {
          add(UpdateUserLogin(user: user));
        },
      );
    }
  }
}
