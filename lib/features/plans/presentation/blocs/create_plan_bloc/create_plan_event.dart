part of 'create_plan_bloc.dart';

abstract class CreatePlanEvent extends Equatable {
  const CreatePlanEvent();

  @override
  List<Object> get props => [];
}

class AddFriendEvent extends CreatePlanEvent {
  final String friendEmail;
  const AddFriendEvent(this.friendEmail);

  @override
  List<Object> get props => [friendEmail];
}
