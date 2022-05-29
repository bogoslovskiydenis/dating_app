import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dating_app/database/db_repository.dart';
import 'package:equatable/equatable.dart';

part 'images_event.dart';

part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _databaseSubsr;

  ImagesBloc({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(ImagesLoading());

  Stream<ImagesState> mapEventToStete(
    ImagesEvent event,
  ) async* {
    if (event is LoadImages) {
      yield* _mapLoadImagesToState(event);
    }
    if (event is UpdateImages) {
      yield* _mapUpdateImagesToState(event);
    }
}

  Stream<ImagesState> _mapLoadImagesToState(LoadImages event) async* {
    _databaseSubsr?.cancel();
    _databaseRepository
        .getUser()
        .listen((user) => add(UpdateImages(user.imageUrls)));
  }

  Stream<ImagesState> _mapUpdateImagesToState(UpdateImages event)async*{
    yield ImagesLoaded(imageUrls: event.imageUrls);
  }
}
