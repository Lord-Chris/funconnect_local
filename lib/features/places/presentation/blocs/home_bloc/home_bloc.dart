import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeInitEvent>(_onHomeInitEvent);
  }

  Future<FutureOr<void>> _onHomeInitEvent(
    HomeInitEvent event,
    Emitter<HomeState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedState());
  }
}
