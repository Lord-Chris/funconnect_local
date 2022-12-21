import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/interest_bloc/interest_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/interest_bloc/interest_state.dart';
import 'package:funconnect/models/failure.dart';

class InterestsBloc extends Bloc<InterestsEvent, InterestsState> {
  InterestsBloc()
      : super(InterestsInitialState(
          selectedInterest: const [],
          interests: List.generate(
            20,
            (index) => "Fine Dining Restaurant $index",
            growable: true,
          ),
        )) {
    on<InterestTapEvent>(_onInterestTapEvent);
    on<ContinueTapEvent>(_onContinueTapEvent);
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

  FutureOr<void> _onContinueTapEvent(
    ContinueTapEvent event,
    Emitter<InterestsState> emit,
  ) {
    try {
      emit(InterestsLoadingState());
      // await _authenticationRepository.setUpProfile(event.param);
      // _navigationService.toNamed(Routes.interestViewRoute);
    } on Failure {
      emit(InterestsErrorState());
    } finally {
      // emit(InterestsInitialState());
    }
  }
}
