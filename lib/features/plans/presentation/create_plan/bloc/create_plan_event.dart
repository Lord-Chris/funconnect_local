part of 'create_plan_bloc.dart';

abstract class CreatePlanEvent extends Equatable {
  const CreatePlanEvent();

  @override
  List<Object> get props => [];
}

class DateSelectTapEvent extends CreatePlanEvent {
  final DateTime? selectedDate;

  const DateSelectTapEvent({required this.selectedDate});
}

class TimeSelectTapEvent extends CreatePlanEvent {
  final TimeOfDay? selectedTime;

  const TimeSelectTapEvent({required this.selectedTime});
}

class SearchOnMapTapEvent extends CreatePlanEvent {
  const SearchOnMapTapEvent();
}
