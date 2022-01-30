import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dating_app/model/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'swipe_event.dart';

part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading());

  @override
  Stream<SwipeState> mapEventToState(
      SwipeEvent event,
      ) async* {
    if (event is LoadUsersEvent) {
      yield* _mapLoadUsersToState(event);
    }
    if (event is SwipeLeftEvent) {
      yield* _mapSwipeLeftEventToState(event, state);
    }
    if (event is SwipeRightEvent) {
      yield* _mapSwipeRightEventToState(event, state);
    }
  }

  Stream<SwipeState> _mapLoadUsersToState(
      LoadUsersEvent event,
      ) async* {
    yield SwipeLoaded(users: event.users);
  }

  Stream<SwipeState> _mapSwipeLeftEventToState(
      SwipeLeftEvent event,
      SwipeState state,
      ) async* {
    if (state is SwipeLoaded) {
      try {
        yield SwipeLoaded(users: List.from(state.users)..remove(event.user));
      } catch (_) {
        SwipeError();
      }
    }
  }

  Stream<SwipeState> _mapSwipeRightEventToState(
      SwipeRightEvent event,
      SwipeState state,
      ) async* {
    if (state is SwipeLoaded) {
      try {
        yield SwipeLoaded(users: List.from(state.users)..remove(event.user));
      } catch (_) {
        SwipeError();
      }
    }
  }
}