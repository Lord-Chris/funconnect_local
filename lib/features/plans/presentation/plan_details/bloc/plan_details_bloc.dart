import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/app/routes.dart';
import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/usecases/fetch_place_detail.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_friend_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_place_model.dart';
import 'package:funconnect/features/plans/domain/usecases/delete_plan_usecase.dart';
import 'package:funconnect/features/plans/domain/usecases/fetch_plan_friends_usecase.dart';
import 'package:funconnect/features/plans/domain/usecases/fetch_plan_places_usecase.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';

import 'package:logger/logger.dart';

part 'plan_details_event.dart';
part 'plan_details_state.dart';

class PlanDetailsBloc extends Bloc<PlanDetailsEvent, PlanDetailsState> {
  PlanDetailsBloc() : super(PlanDetailsInitial()) {
    on<PlanDetailsEvent>((event, emit) {});
    on<PlanPlacesLoad>(_planPlacesLoad);
    on<PlanFriendsLoad>(_planFriendsLoad);
    on<AddAPlaceClickedEvent>(_addAPlaceClicked);
    on<DeletePlanClickedEvent>(_deletePlanClicked);
  }
  final _navigation = locator<INavigationService>();

  FutureOr<void> _planPlacesLoad(
      PlanPlacesLoad event, Emitter<PlanDetailsState> emit) async {
    emit(PlanPlacesLoading());
    try {
      final data = await FetchPlanPlacesUsecase().call(event.plan.id);
      emit(PlanPlacesLoaded(data));
    } catch (e) {
      Logger().e(e);
    }
  }

  FutureOr<void> _planFriendsLoad(
      PlanFriendsLoad event, Emitter<PlanDetailsState> emit) async {
    emit(PlanFriendsLoading());
    try {
      final data = await FetchPlanFriendsUsecase().call(event.plan.id);
      emit(PlanFriendsLoaded(data));
    } catch (e) {
      Logger().e(e);
    }
  }

  FutureOr<void> _addAPlaceClicked(
      AddAPlaceClickedEvent event, Emitter<PlanDetailsState> emit) async {
    await _navigation.toNamed(Routes.planAddPlaceViewRoute,
        arguments: event.plan) as bool;

    emit(PlanFriendsLoading());
    try {
      final data = await FetchPlanFriendsUsecase().call(event.plan.id);
      emit(PlanFriendsLoaded(data));
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<FullPlaceModel> getPlaceDetails(String placeId) async {
    List data = await FetchPlaceDetail().call(placeId);
    return data[0];
  }

  FutureOr<void> _deletePlanClicked(
      DeletePlanClickedEvent event, Emitter<PlanDetailsState> emit) async {
    emit(PlanDetailsLoading());
    var response = await DeletePlanUseCase().call(event.plan.id);
    Logger().i(response);
    _navigation.back();
  }
}
