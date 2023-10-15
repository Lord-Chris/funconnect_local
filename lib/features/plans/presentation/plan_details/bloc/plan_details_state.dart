part of 'plan_details_bloc.dart';

class PlanDetailsState extends Equatable {
  final List<MiniPlanFriend>? invitedFriends;
  const PlanDetailsState({List<MiniPlanFriend>? invitedFriends})
      : invitedFriends = invitedFriends ?? const [];

  @override
  List<Object?> get props => [invitedFriends];

  PlanDetailsState copyWith({List<MiniPlanFriend>? invitedFriends}) {
    return PlanDetailsState(
      invitedFriends: invitedFriends ?? this.invitedFriends,
    );
  }
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
}

class PlanFriendsLoading extends PlanDetailsState {}

class PlanFriendsLoaded extends PlanDetailsState {
  final PaginatedData<MiniPlanFriend> friends;
  const PlanFriendsLoaded(this.friends);

  @override
  List<Object> get props => [friends];
}

class PlanDetailsLoading extends PlanDetailsState {}
