// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class DeletePlanClickedEvent extends PlanDetailsEvent {
  final MiniPlanModel plan;

  const DeletePlanClickedEvent({required this.plan});
}

class PlanPlaceEditEvent extends PlanDetailsEvent {
  final MiniPlanModel plan;
  final MiniPlanPlaceModel place;
  final FullPlaceModel? fullPlace;
  const PlanPlaceEditEvent({
    this.fullPlace,
    required this.plan,
    required this.place,
  });
}
