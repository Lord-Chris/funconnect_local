part of 'plan_list_bloc.dart';

abstract class PlanListEvent extends Equatable {
  const PlanListEvent();

  @override
  List<Object> get props => [];
}

class FetchMiniPlansEvent extends PlanListEvent {}

class CreatePlanClickedEvent extends PlanListEvent {}
