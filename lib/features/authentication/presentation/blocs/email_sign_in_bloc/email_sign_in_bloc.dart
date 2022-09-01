import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/email_sign_in_bloc/email_sign_in_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/email_sign_in_bloc/email_sign_in_state.dart';
import 'package:funconnect/verify_email_view.dart';

class EmailSignInBloc extends Bloc<EmailSignInEvent, EmailSignInState> {
  EmailSignInBloc() : super(EmailSignInInitialState()) {
    on<EmailFieldChangeEvent>(_onEmailFieldChangeEvent);
    on<GetCodeEvent>(_onGetCodeEvent);
  }

  FutureOr<void> _onEmailFieldChangeEvent(
    EmailFieldChangeEvent event,
    Emitter<EmailSignInState> emit,
  ) {}

  FutureOr<void> _onGetCodeEvent(
    GetCodeEvent event,
    Emitter<EmailSignInState> emit,
  ) {
    Navigator.push(
      event.context,
      MaterialPageRoute(builder: (_) => const VerifyEmailView()),
    );
  }
}
