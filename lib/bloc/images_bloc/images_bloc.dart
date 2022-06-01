import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/database/db_repository.dart';

part 'images_event.dart';

part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _databaseSubsr;

  ImagesBloc({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(ImagesLoading()) {
    on<LoadImages>(_onLoadImages);
    on<UpdateImages>(_onUpdateImages);
  }

  void _onLoadImages(LoadImages event, Emitter<ImagesState> emit) {
    _databaseSubsr?.cancel();
    _databaseRepository
        .getUser()
        .listen((user) => add(UpdateImages(user.imageUrls)));
  }

  void _onUpdateImages(UpdateImages event, Emitter<ImagesState> emit) {
    emit(ImagesLoaded(imageUrls: event.imageUrls));
  }
}
