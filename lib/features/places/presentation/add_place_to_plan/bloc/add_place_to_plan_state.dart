part of 'add_place_to_plan_bloc.dart';

abstract class AddPlaceToPlanState extends Equatable {
  const AddPlaceToPlanState();

  @override
  List<Object> get props => [];
}

class AddPlaceToPlanInitial extends AddPlaceToPlanState {}

class AddPlaceToPlanLoading extends AddPlaceToPlanState {}

class PlansListLoaded extends AddPlaceToPlanState {
  final List<MiniPlanModel> plans;
  const PlansListLoaded(this.plans);

  @override
  List<Object> get props => [plans];
}

class PlanListErrorState extends AddPlaceToPlanState {
  final String message;
  const PlanListErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SelectionMadeState extends AddPlaceToPlanState {
  final List<MiniPlanModel> plan;

  const SelectionMadeState(this.plan);
}

class SelectionLoadingState extends AddPlaceToPlanState {}
