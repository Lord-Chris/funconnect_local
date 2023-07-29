import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'plan_details_event.dart';
part 'plan_details_state.dart';

class PlanDetailsBloc extends Bloc<PlanDetailsEvent, PlanDetailsState> {
  PlanDetailsBloc() : super(PlanDetailsInitial()) {
    on<PlanDetailsEvent>((event, emit) {});
  }
}
