part of 'add_place_to_plan_bloc.dart';

abstract class AddPlaceToPlanState extends Equatable {
  const AddPlaceToPlanState();

  @override
  List<Object> get props => [];
}

class AddPlaceToPlanInitial extends AddPlaceToPlanState {}

class AddPlaceToPlanLoading extends AddPlaceToPlanState {}

class PlansListLoaded extends AddPlaceToPlanState {
  final (List<MiniPlanModel>, List<MiniPlanModel>) plans;
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

class DateSelectedState extends AddPlaceToPlanState {
  final DateTime date;
  const DateSelectedState(this.date);

  @override
  List<Object> get props => [date];
}

class TimeSelectedState extends AddPlaceToPlanState {
  final DateTime time;
  const TimeSelectedState(this.time);

  @override
  List<Object> get props => [time];
}

class AddPlaceToPlanSuccessState extends AddPlaceToPlanState {}
