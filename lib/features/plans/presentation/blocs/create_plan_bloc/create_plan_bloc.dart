import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_plan_event.dart';
part 'create_plan_state.dart';

class CreatePlanBloc extends Bloc<CreatePlanEvent, CreatePlanState> {
  CreatePlanBloc() : super(CreatePlanInitial()) {
    on<CreatePlanEvent>((event, emit) {});
    on<AddFriendEvent>(_addFriendEvent);
  }
  List<String> friends = [];

  FutureOr<void> _addFriendEvent(
      AddFriendEvent event, Emitter<CreatePlanState> emit) {
    emit(FriendAddedState(friends..add(event.friendEmail)));
  }
}
