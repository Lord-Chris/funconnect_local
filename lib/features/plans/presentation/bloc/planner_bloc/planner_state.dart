part of 'planner_bloc.dart';

abstract class PlannerState extends Equatable {
  const PlannerState();
  
  @override
  List<Object> get props => [];
}

class PlannerInitial extends PlannerState {}
