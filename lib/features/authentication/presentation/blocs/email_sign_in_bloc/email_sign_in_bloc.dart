import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/authentication/domain/usecases/email_signin_usecase.dart';
import 'package:funconnect/features/authentication/presentation/blocs/email_sign_in_bloc/email_sign_in_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/email_sign_in_bloc/email_sign_in_state.dart';
import 'package:funconnect/models/failure.dart';
import 'package:funconnect/services/_services.dart';

class EmailSignInBloc extends Bloc<EmailSignInEvent, EmailSignInState> {
  EmailSignInBloc() : super(EmailSignInInitialState()) {
    on<EmailFieldChangeEvent>(_onEmailFieldChangeEvent);
    on<GetCodeEvent>(_onGetCodeEvent);
    on<SignInWithEmail>(_onSignInWithEmail);
  }
  final _navigationService = locator<INavigationService>();

  FutureOr<void> _onEmailFieldChangeEvent(
    EmailFieldChangeEvent event,
    Emitter<EmailSignInState> emit,
  ) {}

  FutureOr<void> _onGetCodeEvent(
    GetCodeEvent event,
    Emitter<EmailSignInState> emit,
  ) {
    _navigationService.toNamed(Routes.verifyEmailRoute);
  }

  FutureOr<void> _onSignInWithEmail(
    SignInWithEmail event,
    Emitter<EmailSignInState> emit,
  ) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      emit(EmailSignInLoadingState());
      // await Future.delayed(const Duration(seconds: 2));
      EmailSignInUsecase().call(event.email);
      emit(EmailSignInSuccessState());
    } on Failure {
      emit(EmailSignInErrorState());
    }
  }
}
