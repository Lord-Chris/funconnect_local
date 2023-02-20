import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/services/_services.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc()
      : super(EditProfileInitialState(
            pageController: PageController(initialPage: 0),
            currentIndex: 0,
            profile: ProfileModel.empty())) {
    on<BackTapEvent>(_onBackTapEvent);
    on<ContinueTapEvent>(_onContinueTapEvent);
    on<PageChangeEvent>(_onPageChangeEvent);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
    on<ImageTapEvent>(_onImageTapEvent);
    on<EditProfileFieldsEvent>(_onEditProfileFieldsEvent);
  }

  final _navigationService = locator<INavigationService>();
  final _mediaService = locator<IMediaService>();

  final ImagePicker _imagePicker = ImagePicker();

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
    _navigationService.back();
  }

  Future<FutureOr<void>> _onImageTapEvent(
    ImageTapEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    final File? imageFile = (await _mediaService.pickImage(fromGallery: true));
    if (imageFile != null) {
      File? croppedFile = await _mediaService.getImageCropped(file: imageFile);
      add(EditProfileFieldsEvent(
          state.profile.copyWith(profileImageUrl: croppedFile!.path)));
    }
  }

  Future<FutureOr<void>> _onEditProfileFieldsEvent(
    EditProfileFieldsEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(profile: event.profileModel));
  }
}
