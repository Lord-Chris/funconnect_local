part of 'choose_plan_type_bloc.dart';

abstract class ChoosePlanTypeEvent extends Equatable {
  const ChoosePlanTypeEvent();

  @override
  List<Object> get props => [];
}

class MiniPlanTypeSelectedEvent extends ChoosePlanTypeEvent {}
