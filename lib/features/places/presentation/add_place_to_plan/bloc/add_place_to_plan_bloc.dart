import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_place_to_plan_event.dart';
part 'add_place_to_plan_state.dart';

class AddPlaceToPlanBloc extends Bloc<AddPlaceToPlanEvent, AddPlaceToPlanState> {
  AddPlaceToPlanBloc() : super(AddPlaceToPlanInitial()) {
    on<AddPlaceToPlanEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
