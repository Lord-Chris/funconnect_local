part of 'plan_details_bloc.dart';

abstract class PlanDetailsState extends Equatable {
  const PlanDetailsState();

  @override
  List<Object> get props => [];
}

class PlanDetailsInitial extends PlanDetailsState {}

class PlanPlacesLoading extends PlanDetailsState {}

class PlanDetailsLoaded extends PlanDetailsState {
  final PaginatedData<MiniPlanPlaceModel> places;
  final PaginatedData<MiniPlanFriend> friends;
  const PlanDetailsLoaded({required this.places, required this.friends});

  @override
  List<Object> get props => [places, friends];
}

class PlanPlacesLoaded extends PlanDetailsState {
  final List<MiniPlanPlaceModel> places;
  const PlanPlacesLoaded(this.places);

  @override
  List<Object> get props => [places];
}

class PlanFriendsLoading extends PlanDetailsState {}

class PlanFriendsLoaded extends PlanDetailsState {
  final PaginatedData<MiniPlanFriend> friends;
  const PlanFriendsLoaded(this.friends);

  @override
  List<Object> get props => [friends];
}
