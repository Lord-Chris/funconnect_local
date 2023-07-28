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

  const CreatePlanClickedEvent(
      {required this.planName, required this.planDescription});

  @override
  List<Object> get props => [planName, planDescription];
}

class ChangeReminderTypeEvent extends CreatePlanEvent {
  final ReminderType reminderType;
  const ChangeReminderTypeEvent(this.reminderType);

  @override
  List<Object> get props => [reminderType];
}

class ChangeReminderMediumEvent extends CreatePlanEvent {
  final ReminderMedium reminderMedium;
  const ChangeReminderMediumEvent(this.reminderMedium);

  @override
  List<Object> get props => [reminderMedium];
}
