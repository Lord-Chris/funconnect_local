import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/app/routes.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<EditProfileTapEvent>(_onEditProfileEvent);
    on<ManageLoginOptionsTapEvent>(_onManageLoginOptionsTapEvent);
  }

  final _navigationService = locator<INavigationService>();

  Future<FutureOr<void>> _onEditProfileEvent(
      EditProfileTapEvent event,
      Emitter<ProfileState> emit,
      ) async {
    _navigationService.toNamed(Routes.editProfileViewRoute);
  }
  Future<FutureOr<void>> _onMyTicketEvent(
      MyEventTapEvent event,
      Emitter<ProfileState> emit,
      ) async {
    _navigationService.toNamed(Routes.editProfileViewRoute);
  }
  Future<FutureOr<void>> _onManageLoginOptionsTapEvent(
      ManageLoginOptionsTapEvent event,
      Emitter<ProfileState> emit,
      ) async {
    _navigationService.toNamed(Routes.manageLoginOptionsRoute);
  }
}
