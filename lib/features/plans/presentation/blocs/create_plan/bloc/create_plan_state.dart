part of 'create_plan_bloc.dart';

abstract class CreatePlanState extends Equatable {
  const CreatePlanState();

  @override
  List<Object> get props => [];
}

class CreatePlanInitial extends CreatePlanState {}

class FriendAddedState extends CreatePlanState {
  final List<String> friendsEmails;
  const FriendAddedState(this.friendsEmails);

  @override
  bool operator ==(Object other) => false;

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}

class CreatedPlanLoadingState extends CreatePlanState {}
