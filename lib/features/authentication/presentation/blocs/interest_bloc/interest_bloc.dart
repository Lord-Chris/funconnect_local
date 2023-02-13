import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/fetch_interest_usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/save_interests_usecase.dart';
import 'package:funconnect/features/authentication/presentation/blocs/interest_bloc/interest_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/interest_bloc/interest_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/dialogs/status_dialog.dart';

class InterestsBloc extends Bloc<InterestsEvent, InterestsState> {
  InterestsBloc() : super(const InterestsLoadingState()) {
    on<LoadInterestsEvent>(_onLoadInterestsEvent);
    on<InterestTapEvent>(_onInterestTapEvent);
    on<ContinueTapEvent>(_onContinueTapEvent);
    on<SkipTapEvent>(_onSkipTapEvent);
  }
  final _navigationService = locator<INavigationService>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();

  FutureOr<void> _onLoadInterestsEvent(
    LoadInterestsEvent event,
    Emitter<InterestsState> emit,
  ) async {
    final res = await FetchInterestUseCase().call(NoParams());
    emit(InterestsInitialState(interests: res.data));
  }

  FutureOr<void> _onInterestTapEvent(
    InterestTapEvent event,
    Emitter<InterestsState> emit,
  ) {
    if (state is InterestsLoadingState) return null;

    final selected = [...state.selectedInterest];
    if (selected.contains(event.interest)) {
      selected.remove(event.interest);
    } else {
      selected.add(event.interest);
    }
    emit(InterestsInitialState(
      interests: state.interests,
      selectedInterest: selected,
    ));
  }

  Future<FutureOr<void>> _onContinueTapEvent(
    ContinueTapEvent event,
    Emitter<InterestsState> emit,
  ) async {
    try {
      emit(InterestsLoadingState(
        interests: state.interests,
        selectedInterest: state.selectedInterest,
      ));
      await SaveInterestsUseCases().call(NoParams());
      _navigationService.offAllNamed(Routes.dashboardViewRoute, (_) => false);
    } on Failure catch (e) {
      emit(InterestsErrorState(
        interests: state.interests,
        selectedInterest: state.selectedInterest,
      ));
      _dialogAndSheetService.showAppDialog(StatusDialog(
          isError: true, title: "Error Saving Interests", body: e.message));
    } finally {
      emit(InterestsSuccessState(
        interests: state.interests,
        selectedInterest: state.selectedInterest,
      ));
    }
  }

  FutureOr<void> _onSkipTapEvent(
    SkipTapEvent event,
    Emitter<InterestsState> emit,
  ) {
    _navigationService.offAllNamed(Routes.dashboardViewRoute, (_) => false);
  }
}
