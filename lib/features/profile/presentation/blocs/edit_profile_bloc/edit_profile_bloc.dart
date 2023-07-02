import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/profile/domain/usecases/update_user_location.dart';
import 'package:funconnect/features/profile/domain/usecases/update_user_profile.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/dialogs/status_dialog.dart';

import '../../../domain/usecases/update_profile_image.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  UserModel profile;

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
    on<NumberValidationEvent>(_onNumberValidation);
  }

  final _navigationService = locator<INavigationService>();
  final _mediaService = locator<IMediaService>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();
  final _locationService = locator<ILocationService>();

  bool isNumberValid = false;

  void _onNumberValidation(
    NumberValidationEvent event,
    Emitter<EditProfileState> emit,
  ) {
    isNumberValid = event.isVerified;
  }

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
      if (state.profile.photoUrl.isNotEmpty &&
          !state.profile.photoUrl.startsWith('http')) {
        await UpdateProfileImage().call(File(state.profile.photoUrl));
      }
      final res = await UpdateUserProfile().call(state.profile);
      emit(state.copyWith(isUpdatingProfile: false));
      _navigationService.back(res);
      _dialogAndSheetService.showAppDialog(const StatusDialog(
        isError: false,
        title: "Profile Updated",
        body: "You have successfully updated your profile!",
      ));
    } on Failure catch (e) {
      emit(state.copyWith(isUpdatingProfile: false));
      _dialogAndSheetService.showAppDialog(StatusDialog(
        isError: true,
        title: "Error Updating Profile",
        body: e.message,
      ));
    }
  }

  FutureOr<void> _onImageTapEvent(
    ImageTapEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      File? imageFile = await _mediaService.pickImage(fromGallery: true);
      if (imageFile == null) return;
      imageFile = await _mediaService.getImageCropped(file: imageFile);
      if (imageFile == null) return;
      emit(state.copyWith(
        profile: state.profile.copyWith(photoUrl: imageFile.path),
      ));
    } on Failure catch (e) {
      _dialogAndSheetService.showAppDialog(StatusDialog(
        isError: true,
        title: "Error Selecting Profile Image",
        body: e.message,
      ));
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
    emit(state.copyWith(profile: state.profile.copyWith(location: location)));
    if (location != null) {
      try {
        final res = await UpdateUserLocation().call(location!);
        emit(state.copyWith(
            profile: state.profile.copyWith(location: res.location)));
        _dialogAndSheetService.showAppDialog(const StatusDialog(
            isError: false,
            title: "Location",
            body: "Location Updated Successfully"));
      } on Failure catch (e) {
        _dialogAndSheetService.showAppDialog(StatusDialog(
          isError: true,
          title: "Error Updating Location",
          body: e.message,
        ));
      }
    }
  }

  AppLocation? get location => _locationService.userLocation;
}
