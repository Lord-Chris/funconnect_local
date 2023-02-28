import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/features/profile/domain/usecases/update_profile_image.dart';
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
            profile: profile, isUpdatingProfile: false)) {

    on<BackTapEvent>(_onBackTapEvent);
    on<ContinueTapEvent>(_onContinueTapEvent);
    on<PageChangeEvent>(_onPageChangeEvent);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
    on<ImageTapEvent>(_onImageTapEvent);
    on<EditProfileFieldsEvent>(_onEditProfileFieldsEvent);
  }

  final _navigationService = locator<INavigationService>();
  final _mediaService = locator<IMediaService>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();



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
  }

  Future<FutureOr<void>> _onContinueTapEvent(
    ContinueTapEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    if (state.currentIndex < 3) {
      state.pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
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
    }on Failure catch (e){
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
      final File? imageFile = (await _mediaService.pickImage(
          fromGallery: true));
      if (imageFile != null) {
        File? croppedFile = await _mediaService.getImageCropped(
            file: imageFile);

        final res = await UpdateProfileImage().call(croppedFile!);
        emit(state.copyWith(profile: state.profile.copyWith(
            profileImageUrl: res.profileImageUrl)));
        // add(EditProfileFieldsEvent(
        //     state.profile.copyWith(profileImageUrl: croppedFile!.path)));
      }
    }on Failure catch (e){
      _dialogAndSheetService.showAppDialog(StatusDialog(
          isError: true, title: "Error Updating Profile Image", body: e.message));
    }
  }

  Future<FutureOr<void>> _onEditProfileFieldsEvent(
    EditProfileFieldsEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(profile: event.profileModel));

  }
}
