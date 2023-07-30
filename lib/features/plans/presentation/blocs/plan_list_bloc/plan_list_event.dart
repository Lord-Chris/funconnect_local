part of 'plan_list_bloc.dart';

abstract class PlanListEvent extends Equatable {
  const PlanListEvent();

  @override
  List<Object> get props => [];
}

class FetchMiniPlansEvent extends PlanListEvent {}

class CreatePlanClickedEvent extends PlanListEvent {}

class OpenPlanEvent extends PlanListEvent {
  final MiniPlanModel plan;
  const OpenPlanEvent(this.plan);

  @override
  List<Object> get props => [plan];
}

class LoadMoreEvent extends PlanListEvent {
  final int page;
  const LoadMoreEvent(this.page);

  @override
  List<Object> get props => [page];
}
