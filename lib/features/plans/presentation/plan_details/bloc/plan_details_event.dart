part of 'plan_details_bloc.dart';

abstract class PlanDetailsEvent extends Equatable {
  const PlanDetailsEvent();

  @override
  List<Object> get props => [];
}

class PlanPlacesLoad extends PlanDetailsEvent {
  final MiniPlanModel plan;

  const PlanPlacesLoad(this.plan);

  @override
  List<Object> get props => [plan];
}

class PlanFriendsLoad extends PlanDetailsEvent {
  final MiniPlanModel plan;

  const PlanFriendsLoad(this.plan);

  @override
  List<Object> get props => [plan];
}

class AddAPlaceClickedEvent extends PlanDetailsEvent {
  final MiniPlanModel plan;
  const AddAPlaceClickedEvent(this.plan);

  @override
  List<Object> get props => [];
}
