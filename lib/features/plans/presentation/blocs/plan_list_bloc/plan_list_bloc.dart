import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/domain/usecases/fetch_mini_plans.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';

part 'plan_list_event.dart';
part 'plan_list_state.dart';

class PlanListBloc extends Bloc<PlanListEvent, PlanListState> {
  PlanListBloc() : super(PlanListInitial()) {
    on<PlanListEvent>((event, emit) {});
    on<CreatePlanClickedEvent>(_createPlanClickedEvent);
    on<FetchMiniPlansEvent>(_fetchMiniPlansEvent);
  }

  final _navigation = locator<INavigationService>();

  FutureOr<void> _createPlanClickedEvent(
      CreatePlanClickedEvent event, Emitter<PlanListState> emit) {
    _navigation.toNamed(Routes.choosePlanTypeViewRoute);
  }

  FutureOr<void> _fetchMiniPlansEvent(
      FetchMiniPlansEvent event, Emitter<PlanListState> emit) async {
    final data = await FetchMiniPlansUseCase().call(NoParams());
  }
}
