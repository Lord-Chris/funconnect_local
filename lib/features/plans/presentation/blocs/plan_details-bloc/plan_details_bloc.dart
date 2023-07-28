import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'plan_details_event.dart';
part 'plan_details_state.dart';

class PlanDetailsBloc extends Bloc<PlanDetailsEvent, PlanDetailsState> {
  PlanDetailsBloc() : super(PlanDetailsInitial()) {
    on<PlanDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
