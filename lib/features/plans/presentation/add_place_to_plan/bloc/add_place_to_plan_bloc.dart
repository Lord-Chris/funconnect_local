import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/domain/params/add_place.dart';
import 'package:funconnect/features/plans/domain/usecases/add_plan_place_usecase.dart';
import 'package:funconnect/features/plans/domain/usecases/fetch_mini_plans.dart';
import 'package:funconnect/services/dialog_and_sheet_service/i_dialog_and_sheet_service.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';
import 'package:funconnect/shared/dialogs/add_place_to_plan_confirmation_dialog.dart';
import 'package:funconnect/shared/dialogs/add_place_to_plan_done_dialog.dart';

import 'package:funconnect/shared/dialogs/date_and_time_dialog.dart';
import 'package:logger/logger.dart';

import '../../../../places/domain/entities/full_place_model.dart';

part 'add_place_to_plan_event.dart';
part 'add_place_to_plan_state.dart';

class AddPlaceToPlanBloc
    extends Bloc<AddPlaceToPlanEvent, AddPlaceToPlanState> {
  AddPlaceToPlanBloc() : super(AddPlaceToPlanInitial()) {
    on<AddPlaceToPlanEvent>((event, emit) {});
    on<LoadPlansListEvent>(_loadPlansList);
    on<AddSelectionEvent>(_addSelection);
    on<RemoveSelectionEvent>(_removeSelection);
    on<AddPlaceToPlaButtonClickedEvent>(_addPlaceToPlaButtonClicked);
    on<DateSelectedEvent>(_dateSelected);
    on<TimeSelectedEvent>(_timeSelected);
  }

  List<MiniPlanModel> selectedPlans = [];

  final _dialogAndSheetService = locator<IDialogAndSheetService>();
  final _naviagtionService = locator<INavigationService>();

  DateTime? selectedDate;

  FutureOr<void> _loadPlansList(
      LoadPlansListEvent event, Emitter<AddPlaceToPlanState> emit) async {
    emit(AddPlaceToPlanLoading());
    try {
      (List<MiniPlanModel>, List<MiniPlanModel>) data =
          await FetchMiniPlansUseCase().call(NoParams());

      emit(PlansListLoaded(data));
    } catch (e) {
      Logger().e(e.toString());
      emit(PlanListErrorState(e.toString()));
    }
  }

  FutureOr<void> _addSelection(
      AddSelectionEvent event, Emitter<AddPlaceToPlanState> emit) {
    emit(SelectionLoadingState());
    emit(SelectionMadeState(selectedPlans..add(event.plan)));
  }

  FutureOr<void> _removeSelection(
      RemoveSelectionEvent event, Emitter<AddPlaceToPlanState> emit) {
    emit(SelectionLoadingState());
    selectedPlans.remove(event.plan);
    emit(SelectionMadeState(selectedPlans));
  }

  FutureOr<void> _addPlaceToPlaButtonClicked(
      AddPlaceToPlaButtonClickedEvent event,
      Emitter<AddPlaceToPlanState> emit) async {
    emit(AddPlaceToPlanLoading());
    var dateReceived =
        await _dialogAndSheetService.showAppDialog(const DateAndTimeDialog());
    Logger().i("Date Received $dateReceived");
    if (dateReceived != null) {
      Future.forEach(event.selectedPlans, (element) async {
        await AddPlanPlaceUsecase().call(AddPlaceParams(
            placeId: event.place.id,
            miniPlanId: element.id,
            date: dateReceived.millisecondsSinceEpoch ??
                DateTime.now().millisecondsSinceEpoch));
        Logger().i("Added ${event.place.name} to plan ${element.name}");
      });
      await _dialogAndSheetService.showAppDialog(AddPlaceToPlanConfirmation(
        place: event.place,
        plans: event.selectedPlans,
        selectedDate: dateReceived,
      ));
      final String returnValue =
          await _dialogAndSheetService.showAppDialog(AddPlamToPlaceDoneDialog(
        selectedPlace: event.place,
      ));

      if (returnValue == "view") {
        emit(AddPlaceToPlanSuccessState());
      }
      if (returnValue == "description") {
        _naviagtionService.back();
      }
    }
  }

  FutureOr<void> _dateSelected(
      DateSelectedEvent event, Emitter<AddPlaceToPlanState> emit) {
    selectedDate = event.date;
    emit(DateSelectedState(selectedDate ?? DateTime.now()));
  }

  FutureOr<void> _timeSelected(
      TimeSelectedEvent event, Emitter<AddPlaceToPlanState> emit) {
    DateTime? date;
    if (selectedDate == null) {
      date = DateTime.now();
    } else {
      date = selectedDate;
    }
    selectedDate = DateTime(date!.year, date.month, date.day,
        event.time?.hour ?? date.hour, event.time?.minute ?? date.minute);
    emit(TimeSelectedState(selectedDate ?? DateTime.now()));
  }
}
