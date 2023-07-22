part of 'plan_list_bloc.dart';

abstract class PlanListState extends Equatable {
  const PlanListState();

  @override
  List<Object> get props => [];
}

class PlanListInitial extends PlanListState {}

class PlanListEmptyState extends PlanListState {}

class PlanListFetchedState extends PlanListState {
  final PaginatedData<MiniPlanModel> data;
  const PlanListFetchedState(this.data);

  @override
  List<Object> get props => [data];
}

class PlanListErrorState extends PlanListState {
  final String message;
  const PlanListErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PlanListLoadingState extends PlanListState {}
