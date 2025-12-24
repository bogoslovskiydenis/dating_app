import 'package:bloc/bloc.dart';
import 'package:dating_app/model/models.dart';
import 'package:dating_app/repository/database/db_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'swipe_event.dart';

part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final DatabaseRepository _databaseRepository;
  final String? currentUserId;

  SwipeBloc({
    required DatabaseRepository databaseRepository,
    this.currentUserId,
  })  : _databaseRepository = databaseRepository,
        super(SwipeLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<SwipeLeftEvent>(_onSwipeLeftEvent);
    on<SwipeRightEvent>(_swipeRightEvent);
  }

  void _onLoadUsers(LoadUsers event, Emitter<SwipeState> emit) async {
    if (event.users != null) {
      emit(SwipeLoaded(users: event.users!));
      return;
    }

    final userId = event.currentUserId ?? currentUserId;
    if (userId == null) {
      emit(SwipeError());
      return;
    }

    try {
      emit(SwipeLoading());
      final allUsers = await _databaseRepository.getAllUsers(userId);
      final likedUserIds = await _databaseRepository.getLikedUserIds(userId);
      final likedUserIdsSet = likedUserIds.toSet();
      
      final availableUsers = allUsers
          .where((user) => user.id != null && !likedUserIdsSet.contains(user.id))
          .toList();
      
      print('Available users: ${availableUsers.length}');
      emit(SwipeLoaded(users: availableUsers));
    } catch (e) {
      print('Error loading users: $e');
      emit(SwipeError());
    }
  }

  void _onSwipeLeftEvent(SwipeLeftEvent event, Emitter<SwipeState> emit) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      try {
        emit(SwipeLoaded(users: List.from(state.users)..remove(event.user)));
      } catch (_) {
        emit(SwipeError());
      }
    }
  }

  void _swipeRightEvent(
    SwipeRightEvent event,
    Emitter<SwipeState> emit,
  ) async {
    final userId = event.currentUserId ?? currentUserId;
    
    if (userId == null) {
      print('Error: currentUserId is null');
      return;
    }
    
    if (event.user.id == null) {
      print('Error: event.user.id is null');
      return;
    }

    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      try {
        await _databaseRepository.likeUser(userId, event.user.id!);
        final match = await _databaseRepository.createMatchIfMutual(
          userId,
          event.user.id!,
        );
        final updatedUsers = List<User>.from(state.users)..remove(event.user);
        emit(SwipeLoaded(users: updatedUsers));
        if (match != null) {
          emit(SwipeMatchCreated(match: match, users: updatedUsers));
        }
      } catch (e) {
        print('Error in swipe right: $e');
        emit(SwipeError());
      }
    } else if (state is SwipeMatchCreated) {
      final state = this.state as SwipeMatchCreated;
      try {
        await _databaseRepository.likeUser(userId, event.user.id!);
        final match = await _databaseRepository.createMatchIfMutual(
          userId,
          event.user.id!,
        );
        final updatedUsers = List<User>.from(state.users)..remove(event.user);
        emit(SwipeLoaded(users: updatedUsers));
        if (match != null) {
          emit(SwipeMatchCreated(match: match, users: updatedUsers));
        }
      } catch (e) {
        print('Error in swipe right: $e');
        emit(SwipeError());
      }
    }
  }
}
