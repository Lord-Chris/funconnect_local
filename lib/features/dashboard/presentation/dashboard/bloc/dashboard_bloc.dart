import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/core/utils/failure_handler.dart';
import 'package:funconnect/features/dashboard/domain/usecases/fetch_profile_usecase.dart';
import 'package:funconnect/features/dashboard/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:funconnect/features/dashboard/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:logger/logger.dart';

import '../../../../../services/_services.dart';
import '../../../../places/domain/usecases/fetch_explore.dart';
import '../../../domain/usecases/fetch_place_detail.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardIdleState(0)) {
    on<TabTapEvent>(_onTabTapEvent);
    on<DynamicLinkEvent>(_onDynamicLinkEvent);
    _fetchProfile();
  }

  final _logger = Logger();
  final _dynamicLinkService = locator<IDynamicLinkService>();
  final _navigationService = locator<INavigationService>();

  void _fetchProfile() async {
    try {
      _watchDeepLink();
      await FetchProfileUsecase().call(NoParams());
      FetchExploreUseCase().fetchCategories();
    } on Failure catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
    }
  }

  FutureOr<void> _onTabTapEvent(
    TabTapEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(DashboardIdleState(event.index));
  }

  void _watchDeepLink() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_dynamicLinkService.data != null) {
        add(DynamicLinkEvent(_dynamicLinkService.data!));
        await stream.first;
      }
      _dynamicLinkService.linkStream.listen((link) {
        add(DynamicLinkEvent(_dynamicLinkService.data!));
      });
    });
  }

  Future<void> _handleDeepLink(DeepLinkDataModel? data) async {
    _logger.f(data);
    if (data == null) return;
    if (data.type != "place") return;
    final place = await FetchPlaceDetail().call(data.value);
    _navigationService.toNamed(Routes.placeDetailRoute, arguments: place);
    _dynamicLinkService.clearData();
  }

  FutureOr<void> _onDynamicLinkEvent(
    DynamicLinkEvent event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is! DashboardIdleState) return null;
    final prevState = (state as DashboardIdleState);
    try {
      emit(const LinkLoadingState());
      await _handleDeepLink(event.data);
    } on Failure catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
    } finally {
      emit(prevState);
    }
  }
}
