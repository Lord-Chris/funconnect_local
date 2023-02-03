import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitialState(PageController(initialPage: 0), 0)) {
    on<BackTapEvent>(_onBackTapEvent);
    on<ContinueTapEvent>(_onContinueTapEvent);
    on<PageChangeEvent>(_onPageChangeEvent);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
  }
  final _navigationService = locator<INavigationService>();

  Future<FutureOr<void>> _onBackTapEvent(
      BackTapEvent event,
      Emitter<EditProfileState> emit,
      ) async {
    if(state.currentIndex > 0){
      state.pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }else {
      _navigationService.back();
    }
  }

  Future<FutureOr<void>> _onContinueTapEvent(
      ContinueTapEvent event,
      Emitter<EditProfileState> emit,
      ) async {
    if(state.currentIndex < 3){
      state.pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }
  Future<FutureOr<void>> _onPageChangeEvent(
      PageChangeEvent event,
      Emitter<EditProfileState> emit,
      ) async {
    emit(EditProfileState(state.pageController, event.pageIndex));
  }

  Future<FutureOr<void>> _onUpdateProfileEvent(
      UpdateProfileEvent event,
      Emitter<EditProfileState> emit,
      ) async {
      _navigationService.back();

  }
}
