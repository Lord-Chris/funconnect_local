import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/app/routes.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';

part 'choose_plan_type_event.dart';
part 'choose_plan_type_state.dart';

class ChoosePlanTypeBloc
    extends Bloc<ChoosePlanTypeEvent, ChoosePlanTypeState> {
  ChoosePlanTypeBloc() : super(ChoosePlanTypeInitial()) {
    on<ChoosePlanTypeEvent>((event, emit) {});
    on<MiniPlanTypeSelectedEvent>(_miniPlanTypeSelectedEvent);
  }

  final _navigation = locator<INavigationService>();

  FutureOr<void> _miniPlanTypeSelectedEvent(
      MiniPlanTypeSelectedEvent event, Emitter<ChoosePlanTypeState> emit) {
    _navigation.toNamed(Routes.createPlanViewRoute);
  }
}
