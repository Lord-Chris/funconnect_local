import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/models/failure.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/dashboard/domain/usecases/fetch_profile_usecase.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_event.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_state.dart';
import 'package:logger/logger.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardIdleState(0)) {
    on<TabTapEvent>(_onTabTapEvent);
    _fetchProfile();
  }

  final _logger = Logger();

  void _fetchProfile() async {
    try {
      await FetchProfileUsecase().call(NoParams());
    } on Failure catch (e) {
      _logger.e(e);
    }
  }

  FutureOr<void> _onTabTapEvent(
    TabTapEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(DashboardIdleState(event.index));
  }
}
