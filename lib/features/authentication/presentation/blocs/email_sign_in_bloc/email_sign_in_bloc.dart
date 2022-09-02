import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/authentication/presentation/blocs/email_sign_in_bloc/email_sign_in_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/email_sign_in_bloc/email_sign_in_state.dart';
import 'package:funconnect/services/_services.dart';

class EmailSignInBloc extends Bloc<EmailSignInEvent, EmailSignInState> {
  EmailSignInBloc() : super(EmailSignInInitialState()) {
    on<EmailFieldChangeEvent>(_onEmailFieldChangeEvent);
    on<GetCodeEvent>(_onGetCodeEvent);
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
}
