part of 'create_plan_bloc.dart';

abstract class CreatePlanState extends Equatable {
  const CreatePlanState();

  @override
  List<Object> get props => [];
}

class CreatePlanInitial extends CreatePlanState {}

class DateChangedState extends CreatePlanState {
  final DateTime selectedDate;

  const DateChangedState({required this.selectedDate});
}

class TimeChangedState extends CreatePlanState {
  final TimeOfDay selectedTime;

  const TimeChangedState({required this.selectedTime});
}
