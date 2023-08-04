part of 'add_place_to_plan_bloc.dart';

abstract class AddPlaceToPlanEvent extends Equatable {
  const AddPlaceToPlanEvent();

  @override
  List<Object> get props => [];
}

class LoadPlansListEvent extends AddPlaceToPlanEvent {}

class SelectionMadeEvent extends AddPlaceToPlanEvent {
  final MiniPlanModel plan;

  const SelectionMadeEvent(this.plan);
}

class AddSelectionEvent extends AddPlaceToPlanEvent {
  final MiniPlanModel plan;

  const AddSelectionEvent(this.plan);
}

class RemoveSelectionEvent extends AddPlaceToPlanEvent {
  final MiniPlanModel plan;

  const RemoveSelectionEvent(this.plan);
}

class AddPlaceToPlaButtonClickedEvent extends AddPlaceToPlanEvent {
  final PlaceModel place;
  final List<MiniPlanModel> selectedPlans;

  const AddPlaceToPlaButtonClickedEvent(
      {required this.place, required this.selectedPlans});
}
