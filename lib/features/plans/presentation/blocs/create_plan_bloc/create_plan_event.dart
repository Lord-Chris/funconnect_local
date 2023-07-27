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

class RemoveFriendEvent extends CreatePlanEvent {
  final String friendEmail;
  const RemoveFriendEvent(this.friendEmail);

  @override
  List<Object> get props => [friendEmail];
}

class CreatePlanClickedEvent extends CreatePlanEvent {
  final String planName;
  final String planDescription;
  final ReminderType reminderType;
  final ReminderMedium reminderMedium;

  const CreatePlanClickedEvent(this.planName, this.planDescription,
      this.reminderType, this.reminderMedium);

  @override
  List<Object> get props =>
      [planName, planDescription, reminderType, reminderMedium];
}
