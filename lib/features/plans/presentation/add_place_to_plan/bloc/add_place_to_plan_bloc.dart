import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/domain/usecases/fetch_mini_plans.dart';
import 'package:funconnect/services/dialog_and_sheet_service/i_dialog_and_sheet_service.dart';

import 'package:funconnect/shared/dialogs/date_and_time_dialog.dart';
import 'package:logger/logger.dart';

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
  }

  List<MiniPlanModel> selectedPlans = [];

  final _dialogAndSheetService = locator<IDialogAndSheetService>();

  FutureOr<void> _loadPlansList(
      LoadPlansListEvent event, Emitter<AddPlaceToPlanState> emit) async {
    emit(AddPlaceToPlanLoading());
    try {
      List<MiniPlanModel> data = await FetchMiniPlansUseCase().call(NoParams());

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
      Emitter<AddPlaceToPlanState> emit) {
    emit(AddPlaceToPlanLoading());
    _dialogAndSheetService.showAppDialog(const DateAndTimeDialog());
  }
}
