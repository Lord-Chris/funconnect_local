import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/fetch_interest_usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/save_interests_usecase.dart';
import 'package:funconnect/features/authentication/presentation/blocs/interest_bloc/interest_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/interest_bloc/interest_state.dart';
import 'package:funconnect/models/failure.dart';

class InterestsBloc extends Bloc<InterestsEvent, InterestsState> {
  InterestsBloc() : super(InterestsLoadingState()) {
    on<LoadInterestsEvent>(_onLoadInterestsEvent);
    on<InterestTapEvent>(_onInterestTapEvent);
    on<ContinueTapEvent>(_onContinueTapEvent);
  }

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
    if (state is! InterestsInitialState) return null;
    // ignore: no_leading_underscores_for_local_identifiers
    final _state = (state as InterestsInitialState);
    final selected = [..._state.selectedInterest];
    if (selected.contains(event.interest)) {
      selected.remove(event.interest);
    } else {
      selected.add(event.interest);
    }
    emit(InterestsInitialState(
      interests: _state.interests,
      selectedInterest: selected,
    ));
  }

  Future<FutureOr<void>> _onContinueTapEvent(
    ContinueTapEvent event,
    Emitter<InterestsState> emit,
  ) async {
    try {
      emit(InterestsLoadingState());
      await SaveInterestsUseCases().call(NoParams());
      // _navigationService.toNamed(Routes.interestViewRoute);
    } on Failure {
      emit(InterestsErrorState());
    } finally {
      emit(InterestsSuccessState());
    }
  }
}
