import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';

part 'create_plan_event.dart';
part 'create_plan_state.dart';

class CreatePlanBloc extends Bloc<CreatePlanEvent, CreatePlanState> {
  CreatePlanBloc() : super(CreatePlanInitial()) {
    on<CreatePlanEvent>((event, emit) {});
    on<AddFriendEvent>(_addFriendEvent);
    on<RemoveFriendEvent>(_removeFriendEvent);
    on<CreatePlanClickedEvent>(_createPlanClickedEvent);
  }
  List<String> friends = [];

  FutureOr<void> _addFriendEvent(
      AddFriendEvent event, Emitter<CreatePlanState> emit) {
    emit(FriendAddedState(friends..add(event.friendEmail)));
  }

  FutureOr<void> _removeFriendEvent(
      RemoveFriendEvent event, Emitter<CreatePlanState> emit) {
    emit(FriendAddedState(friends..remove(event.friendEmail)));
  }

  FutureOr<void> _createPlanClickedEvent(
      CreatePlanClickedEvent event, Emitter<CreatePlanState> emit) {
    emit(CreatedPlanLoadingState());
  }
}
