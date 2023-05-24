import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/app/routes.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/core/utils/general_utils.dart';
import 'package:funconnect/features/profile/domain/usecases/delete_user_account.dart';
import 'package:funconnect/features/profile/domain/usecases/fetch_user_profile.dart';
import 'package:funconnect/features/profile/domain/usecases/logout_user.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:funconnect/shared/dialogs/_dialogs.dart';
import 'package:launch_review/launch_review.dart';
import 'package:logger/logger.dart';

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
    on<TelegramTapEvent>(_onTelegramTapEvent);
    on<InstagramTapEvent>(_onInstagramTapEvent);
    on<TwitterTapEvent>(_onTwitterTapEvent);
    on<HelpDeskTapEvent>(_onHelpDeskTapEvent);
  }

  final _navigationService = locator<INavigationService>();
  final _forceUpdateAppService = locator<IForceUpdateAppService>();
  final _locationService = locator<ILocationService>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();

  final _logger = Logger();

  String? appVersion;

  Future<FutureOr<void>> _onInitProfileEvent(
    InitProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await FetchUserProfile().call(NoParams());
    appVersion = await _forceUpdateAppService.currentVersionRaw;
    UserModel userProfileWithLocation = res.copyWith(location: location);
    emit(ProfileIdleState(userProfile: userProfileWithLocation));
  }

  Future<FutureOr<void>> _onEditProfileEvent(
    EditProfileTapEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final userProfile = await _navigationService
        .toNamed(Routes.editProfileViewRoute, arguments: event.userProfile);
    if (userProfile != null && userProfile is UserModel) {
      emit(ProfileIdleState(userProfile: userProfile));
    }
  }

  Future<FutureOr<void>> _onMyTicketTapEvent(
    MyTicketTapEvent event,
    Emitter<ProfileState> emit,
  ) async {
    _dialogAndSheetService.showAppDialog(
      const ComingSoonDialog(
        icon: AppAssets.savedIconSvg,
        label: "My Tickets is Coming Soon",
      ),
    );
  }

  Future<FutureOr<void>> _onMyEventsTapEvent(
    MyEventTapEvent event,
    Emitter<ProfileState> emit,
  ) async {
    _dialogAndSheetService.showAppDialog(
      const ComingSoonDialog(
        icon: AppAssets.eventIconSvg,
        label: "My Events is Coming Soon",
      ),
    );
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
    await LaunchReview.launch(
      iOSAppId: '1618585581',
      androidAppId: 'com.funconnect.app',
    );
    // RateMyApp rateMyApp =
    //     RateMyApp(minDays: 1, minLaunches: 3, appStoreIdentifier: '1618585581');
    // rateMyApp.showStarRateDialog(
    //   event.context,
    //   title: 'Rate this app',
    //   message:
    //       'You like this app ? Then take a little bit of your time to leave a rating :',
    //   actionsBuilder: (context, stars) {
    //     return [
    //       AppButton(
    //         label: 'OK',
    //         onTap: () async {
    //           await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
    //           Navigator.pop<RateMyAppDialogButton>(
    //               context, RateMyAppDialogButton.rate);
    //           _navigationService.back();
    //         },
    //       ),
    //     ];
    //   },
    //   // ignoreNativeDialog: Platform
    //   //     .isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
    //   // dialogStyle: const DialogStyle(
    //   //   // Custom dialog styles.
    //   //   titleAlign: TextAlign.center,
    //   //   messageAlign: TextAlign.center,
    //   //   messagePadding: EdgeInsets.only(bottom: 20),
    //   // ),
    //   // starRatingOptions:
    //   //     const StarRatingOptions(), // Custom star bar rating options.
    //   onDismissed: () {
    //     print("HERE");
    //     rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed);
    //   }, // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
    // );
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
    _dialogAndSheetService.showAppDialog(AppAlertDialog(
      isHighPriority: false,
      title: "Logout",
      body: "Are you sure you want to logout of this device?",
      positiveLabel: "Log Out",
      negativeLabel: "Cancel",
      negativeCallBack: () {
        _navigationService.back();
      },
      positiveCallBack: () async {
        try {
          LogoutUser().call(NoParams());
          _navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
          _dialogAndSheetService.showAppDialog(
            const StatusDialog(
              isError: false,
              title: "Log Out",
              body: "User Logged out Successfully",
            ),
          );
        } on Failure catch (e) {
          _logger.e(e);
        }
      },
    ));
  }

  FutureOr<void> _onDeleteAccountTapEvent(
    DeleteTapAccountEvent event,
    Emitter<ProfileState> emit,
  ) async {
    _dialogAndSheetService.showAppDialog(AppAlertDialog(
      isHighPriority: true,
      title: "Delete Account",
      body: "Are you sure you want to delete your account?",
      positiveLabel: "Delete",
      negativeLabel: "Cancel",
      negativeCallBack: () {
        _navigationService.back();
      },
      positiveCallBack: () async {
        try {
          await DeleteUserAccount().call(NoParams());
          _navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
          _dialogAndSheetService.showAppDialog(const StatusDialog(
              isError: false, title: "Alert", body: "User Account Deleted"));
        } on Failure catch (e) {
          _navigationService.back();
          _dialogAndSheetService.showAppDialog(StatusDialog(
              isError: true, title: "Error Deleting Account", body: e.message));
        }
      },
    ));
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

  FutureOr<void> _onTelegramTapEvent(
    TelegramTapEvent event,
    Emitter<ProfileState> emit,
  ) {
    GeneralUtils.openUrl(Uri.parse(AppConstants.telegramUrl));
  }

  FutureOr<void> _onTwitterTapEvent(
    TwitterTapEvent event,
    Emitter<ProfileState> emit,
  ) {
    GeneralUtils.openAppRelatedUrl(Uri.parse(AppConstants.twitterUrl));
  }

  FutureOr<void> _onInstagramTapEvent(
    InstagramTapEvent event,
    Emitter<ProfileState> emit,
  ) {
    GeneralUtils.openAppRelatedUrl(Uri.parse(AppConstants.instagramUrl));
  }

  FutureOr<void> _onHelpDeskTapEvent(
    HelpDeskTapEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      if (this.state is! ProfileIdleState) return;
      final state = this.state as ProfileIdleState;
      final res = await _dialogAndSheetService.showAppDialog(
        HelpDeskDialog(user: state.userProfile),
      );

      if (res == null) return;

      ///
      if (res == true) {
        _dialogAndSheetService.showAppDialog(
          const StatusDialog(
            isError: false,
            title: 'Request Sent!',
            body:
                'Your support request has been received. We will be in touch with you shortly with a resolution.',
          ),
        );
      } else if (res is Failure) {
        _logger.e(res);
        _dialogAndSheetService.showAppDialog(
          StatusDialog(
            isError: true,
            title: 'Request Not Sent',
            body: res.message,
          ),
        );
      }
    } on Failure catch (e) {
      _logger.e(e);
      _dialogAndSheetService.showAppDialog(
        StatusDialog(
          isError: true,
          title: 'Request Not Sent',
          body: e.message,
        ),
      );
    }
  }

  AppLocation? get location => _locationService.userLocation;
}
