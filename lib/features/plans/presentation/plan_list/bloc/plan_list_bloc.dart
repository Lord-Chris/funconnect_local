import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/domain/usecases/fetch_mini_plans.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';
import 'package:logger/logger.dart';

part 'plan_list_event.dart';
part 'plan_list_state.dart';

class PlanListBloc extends Bloc<PlanListEvent, PlanListState> {
  PlanListBloc() : super(PlanListInitial()) {
    on<PlanListEvent>((event, emit) {});
    on<CreatePlanClickedEvent>(_createPlanClickedEvent);
    on<FetchMiniPlansEvent>(_fetchMiniPlansEvent);
    on<OpenPlanEvent>(_openPlanEvent);
    on<LoadMoreEvent>(_loadMoreEvent);
  }

  final _navigation = locator<INavigationService>();

  FutureOr<void> _createPlanClickedEvent(
      CreatePlanClickedEvent event, Emitter<PlanListState> emit) async {
    await _navigation.toNamed(Routes.choosePlanTypeViewRoute);
    emit(PlanListLoadingState());
    List<MiniPlanModel> data = await FetchMiniPlansUseCase().call(NoParams());
    emit(PlanListFetchedState(data));
  }

  FutureOr<void> _fetchMiniPlansEvent(
      FetchMiniPlansEvent event, Emitter<PlanListState> emit) async {
    emit(PlanListLoadingState());
    try {
      List<MiniPlanModel> data = await FetchMiniPlansUseCase().call(NoParams());
      if (data.isEmpty) {
        emit(PlanListEmptyState());
      } else {
        emit(PlanListFetchedState(data));
      }
    } catch (e) {
      Logger().e(e.toString());
      emit(PlanListErrorState(e.toString()));
    }
  }

  FutureOr<void> _openPlanEvent(
      OpenPlanEvent event, Emitter<PlanListState> emit) async {
    await _navigation.toNamed(Routes.planDetailViewRoute,
        arguments: event.plan);
    add(FetchMiniPlansEvent());
  }

  FutureOr<void> _loadMoreEvent(
      LoadMoreEvent event, Emitter<PlanListState> emit) {}
}
