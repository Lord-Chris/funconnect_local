import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/app/routes.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/features/profile/domain/usecases/fetch_user_profile.dart';
import 'package:funconnect/services/_services.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoadingState()) {
    on<InitProfileEvent>(_onInitProfileEvent);
    on<EditProfileTapEvent>(_onEditProfileEvent);
    on<MyTicketTapEvent>(_onMyTicketTapEvent);
    on<MyEventTapEvent>(_onMyEventsTapEvent);
    on<ManageLoginOptionsTapEvent>(_onManageLoginOptionsTapEvent);
    on<RateYourExperienceTapEvent>(_onRateYourExperienceTapEvent);
    on<NotificationsTapEvent>(_onNotificationsTapEvent);
    on<LogoutTapEvent>(_onLogoutTapEvent);
  }

  final _navigationService = locator<INavigationService>();
  final _localStorageService = locator<ILocalStorageService>();

  Future<FutureOr<void>> _onInitProfileEvent(
    InitProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await FetchUserProfile().call(NoParams());
    emit(ProfileIdleState(userProfile: res));
  }

  Future<FutureOr<void>> _onEditProfileEvent(
    EditProfileTapEvent event,
    Emitter<ProfileState> emit,
  ) async {
      final userProfile = await _navigationService.toNamed(Routes.editProfileViewRoute,arguments:event.userProfile);
      if(userProfile != null && userProfile is ProfileModel){
        emit(ProfileIdleState(userProfile: userProfile));
      }



  }

  Future<FutureOr<void>> _onMyTicketTapEvent(
    MyTicketTapEvent event,
    Emitter<ProfileState> emit,
  ) async {
    _navigationService.toNamed(Routes.myTicketRoute);
  }

  Future<FutureOr<void>> _onMyEventsTapEvent(
    MyEventTapEvent event,
    Emitter<ProfileState> emit,
  ) async {
    _navigationService.toNamed(Routes.myEventRoute);
  }

  Future<FutureOr<void>> _onManageLoginOptionsTapEvent(
    ManageLoginOptionsTapEvent event,
    Emitter<ProfileState> emit,
  ) async {
    _navigationService.toNamed(Routes.manageLoginOptionsRoute);
  }

  Future<FutureOr<void>> _onRateYourExperienceTapEvent(
    RateYourExperienceTapEvent event,
    Emitter<ProfileState> emit,
  ) async {
    _navigationService.toNamed(Routes.rateYourExperienceRoute);
  }

  Future<FutureOr<void>> _onNotificationsTapEvent(
    NotificationsTapEvent event,
    Emitter<ProfileState> emit,
  ) async {
    _navigationService.toNamed(Routes.notificationsViewRoute);
  }

  FutureOr<void> _onLogoutTapEvent(
    LogoutTapEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await _localStorageService.clearBox(HiveKeys.userBoxId);
    await _localStorageService.clearBox(HiveKeys.placesBoxId);
    await _localStorageService.clearBox(HiveKeys.profileBoxId);
    _navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
  }
}
