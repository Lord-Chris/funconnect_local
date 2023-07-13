import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_plan_event.dart';
part 'create_plan_state.dart';

class CreatePlanBloc extends Bloc<CreatePlanEvent, CreatePlanState> {
  CreatePlanBloc() : super(CreatePlanInitial()) {
    on<CreatePlanEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
