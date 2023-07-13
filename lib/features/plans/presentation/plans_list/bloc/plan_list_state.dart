part of 'plan_list_bloc.dart';

abstract class PlanListState extends Equatable {
  const PlanListState();
  
  @override
  List<Object> get props => [];
}

class PlanListInitial extends PlanListState {}
