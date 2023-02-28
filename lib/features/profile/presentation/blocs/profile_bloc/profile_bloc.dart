import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/app/routes.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/core/utils/general_utils.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/features/profile/domain/usecases/delete_user_account.dart';
import 'package:funconnect/features/profile/domain/usecases/fetch_user_profile.dart';
import 'package:funconnect/features/profile/domain/usecases/logout_user.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:rate_my_app/rate_my_app.dart';

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
    on<DeleteTapAccountEvent>(_onDeleteAccountTapEvent);
    on<TermsOfUseTapEvent>(_onTermsOfUseTapEvent);
    on<PrivacyPolicyTapEvent>(_onPrivacyPolicyTapEvent);
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
    final userProfile = await _navigationService
        .toNamed(Routes.editProfileViewRoute, arguments: event.userProfile);
    if (userProfile != null && userProfile is ProfileModel) {
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
    _navigationService.toNamed(Routes.manageLoginOptionsRoute,
        arguments: event.userProfile);
  }

  Future<FutureOr<void>> _onRateYourExperienceTapEvent(
    RateYourExperienceTapEvent event,
    Emitter<ProfileState> emit,
  ) async {
    RateMyApp rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 7,
      minLaunches: 10,
      remindDays: 7,
      remindLaunches: 10,
      googlePlayIdentifier: 'com.funconnect.app',
      appStoreIdentifier: 'com.funconnect.app',
    );
    rateMyApp.showStarRateDialog(
      event.context,
      title: 'Rate this app',
      message:
          'You like this app ? Then take a little bit of your time to leave a rating :',
      actionsBuilder: (context, stars) {
        return [
          AppButton(
            label: 'OK',
            onTap: () async {
              await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
              Navigator.pop<RateMyAppDialogButton>(
                  context, RateMyAppDialogButton.rate);
              _navigationService.back();
            },
          ),
        ];
      },
      ignoreNativeDialog: Platform
          .isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
      dialogStyle: const DialogStyle(
        // Custom dialog styles.
        titleAlign: TextAlign.center,
        messageAlign: TextAlign.center,
        messagePadding: EdgeInsets.only(bottom: 20),
      ),
      starRatingOptions:
          const StarRatingOptions(), // Custom star bar rating options.
      onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
          .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
    );
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
    await LogoutUser().call(NoParams());
    _navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
  }

  FutureOr<void> _onDeleteAccountTapEvent(
    DeleteTapAccountEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await DeleteUserAccount().call(NoParams());
    _navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
  }

  FutureOr<void> _onTermsOfUseTapEvent(
    TermsOfUseTapEvent event,
    Emitter<ProfileState> emit,
  ) {
    GeneralUtils.openUrl(Uri.parse(AppConstants.tandC));
  }

  FutureOr<void> _onPrivacyPolicyTapEvent(
    PrivacyPolicyTapEvent event,
    Emitter<ProfileState> emit,
  ) {
    GeneralUtils.openUrl(Uri.parse(AppConstants.privacyPolicy));
  }
}
