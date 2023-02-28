import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/features/profile/domain/usecases/update_profile_image.dart';
import 'package:funconnect/features/profile/domain/usecases/update_user_location.dart';
import 'package:funconnect/features/profile/domain/usecases/update_user_profile.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/dialogs/status_dialog.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  ProfileModel profile;

  EditProfileBloc(this.profile)
      : super(EditProfileInitialState(
            pageController: PageController(initialPage: 0),
            currentIndex: 0,
            profile: profile,
            isUpdatingProfile: false,
            autoValidateForm: false)) {
    on<BackTapEvent>(_onBackTapEvent);
    on<ContinueTapEvent>(_onContinueTapEvent);
    on<PageChangeEvent>(_onPageChangeEvent);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
    on<ImageTapEvent>(_onImageTapEvent);
    on<EditProfileFieldsEvent>(_onEditProfileFieldsEvent);
    on<AutoValidateFormEvent>(_onAutoValidateFormEvent);
    on<UpdateLocationTapEvent>(_onUpdateLocationTapEvent);
  }

  final _navigationService = locator<INavigationService>();
  final _mediaService = locator<IMediaService>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();
  final _locationService = locator<ILocationService>();

  Future<FutureOr<void>> _onBackTapEvent(
    BackTapEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    if (state.currentIndex > 0) {
      state.pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      _navigationService.back();
    }
    emit(state.copyWith(autoValidateForm: false));
  }

  Future<FutureOr<void>> _onContinueTapEvent(
    ContinueTapEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    if (state.currentIndex < 3) {
      state.pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      emit(state.copyWith(autoValidateForm: false));
    }
  }

  Future<FutureOr<void>> _onPageChangeEvent(
    PageChangeEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(currentIndex: event.pageIndex));
  }

  Future<FutureOr<void>> _onUpdateProfileEvent(
    UpdateProfileEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(isUpdatingProfile: true));
    try {
      final res = await UpdateUserProfile().call(state.profile);
      emit(state.copyWith(isUpdatingProfile: false));
      _navigationService.back(res);
    } on Failure catch (e) {
      emit(state.copyWith(isUpdatingProfile: false));
      _dialogAndSheetService.showAppDialog(StatusDialog(
          isError: true, title: "Error Updating Profile", body: e.message));
    }
  }

  Future<FutureOr<void>> _onImageTapEvent(
    ImageTapEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      final File? imageFile =
          (await _mediaService.pickImage(fromGallery: true));
      if (imageFile != null) {
        File? croppedFile =
            await _mediaService.getImageCropped(file: imageFile);

        final res = await UpdateProfileImage().call(croppedFile!);
        emit(state.copyWith(
            profile:
                state.profile.copyWith(profileImageUrl: res.profileImageUrl)));
        _dialogAndSheetService.showAppDialog(const StatusDialog(
            isError: false,
            title: "Profile Image",
            body: "Profile Image Uploaded Successfully"));
        // add(EditProfileFieldsEvent(
        //     state.profile.copyWith(profileImageUrl: croppedFile!.path)));
      }
    } on Failure catch (e) {
      _dialogAndSheetService.showAppDialog(StatusDialog(
          isError: true,
          title: "Error Updating Profile Image",
          body: e.message));
    }
  }

  Future<FutureOr<void>> _onEditProfileFieldsEvent(
    EditProfileFieldsEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(profile: event.profileModel));
  }

  Future<FutureOr<void>> _onAutoValidateFormEvent(
    AutoValidateFormEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(autoValidateForm: true));
  }

  Future<FutureOr<void>> _onUpdateLocationTapEvent(
    UpdateLocationTapEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
        state.copyWith(profile: state.profile.copyWith(appLocation: location)));
    if (location != null) {
      try {
        final res = await UpdateUserLocation().call(location!);
        emit(state.copyWith(
            profile: state.profile.copyWith(appLocation: res.appLocation)));
        _dialogAndSheetService.showAppDialog(const StatusDialog(
            isError: false,
            title: "Location",
            body: "Location Updated Successfully"));
      } on Failure catch (e) {
        _dialogAndSheetService.showAppDialog(StatusDialog(
            isError: true,
            title: "Error Updating Location",
            body: e.message));
      }
    }
  }

  AppLocation? get location => _locationService.userLocation;
}
