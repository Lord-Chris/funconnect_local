import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/dashboard/domain/usecases/fetch_profile_usecase.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_event.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_state.dart';
import 'package:logger/logger.dart';

import '../../../../../services/_services.dart';
import '../../../domain/usecases/fetch_place_detail.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardIdleState(0)) {
    on<TabTapEvent>(_onTabTapEvent);
    _fetchProfile();
  }

  final _logger = Logger();
  final _dynamicLinkService = locator<IDynamicLinkService>();
  final _navigationService = locator<INavigationService>();

  void _fetchProfile() async {
    try {
      _watchDeepLink();
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

  void _watchDeepLink() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkForDeepLink(_dynamicLinkService.data);
      _dynamicLinkService.linkStream.listen((link) {
        _checkForDeepLink(link);
      });
    });
  }

  Future<void> _checkForDeepLink(DeepLinkDataModel? data) async {
    _logger.wtf(data);
    if (data == null) return;
    if (data.type != "place") return;
    // ignore: invalid_use_of_visible_for_testing_member
    emit(const LinkLoadingState());
    final place = await FetchPlaceDetail().call(data.value);
    _navigationService.toNamed(Routes.placeDetailRoute, arguments: place);
  }
}
