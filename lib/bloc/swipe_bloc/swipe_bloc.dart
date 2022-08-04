import 'package:bloc/bloc.dart';
import 'package:dating_app/model/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'swipe_event.dart';

part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<SwipeLeftEvent>(_onSwipeLeftEvent);
    on<SwipeRightEvent>(_swipeRightEvent);
  }

  void _onLoadUsers(LoadUsers event, Emitter<SwipeState> emit) {
    emit(SwipeLoaded(users: event.users!));
  }

  void _onSwipeLeftEvent(SwipeLeftEvent event, Emitter<SwipeState> emit) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      try {
        emit(SwipeLoaded(users: List.from(state.users)..remove(event.user)));
      } catch (_) {
        SwipeError();
      }
    }
  }

  void _swipeRightEvent(
    SwipeRightEvent event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      try {
        emit(SwipeLoaded(users: List.from(state.users)..remove(event.user)));
      } catch (_) {
        SwipeError();
      }
    }
  }
}
