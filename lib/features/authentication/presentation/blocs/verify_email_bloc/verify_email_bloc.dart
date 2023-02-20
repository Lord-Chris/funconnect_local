import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/authentication/data/dto/request_otp_response.dart';
import 'package:funconnect/features/authentication/data/repositories/_authentication_repo.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';
import 'package:funconnect/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:funconnect/features/authentication/presentation/blocs/verify_email_bloc/verify_email_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/verify_email_bloc/verify_email_state.dart';
import 'package:funconnect/services/_services.dart';

import '../../../../../shared/dialogs/status_dialog.dart';
import '../../../domain/usecases/email_signin_usecase.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  VerifyEmailBloc() : super(VerifyEmailInitialState()) {
    on<ResendCodeEvent>(_onResendCodeEvent);
    on<PinFieldChangedEvent>(_onPinFieldChangedEvent);
    on<VerifyEmailTapEvent>(_onVerifyEmailTapEvent);
    on<ChangeTimerEvent>(_onChangeTimerEvent);
  }

  static const otpTimer = 90;
  final _authenticationRepo = locator<IAuthenticationRepository>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();
  RequestOtpResponse? newResponse;

  FutureOr<void> _onResendCodeEvent(
    ResendCodeEvent event,
    Emitter<VerifyEmailState> emit,
  ) async {
    try {
      newResponse = await EmailSignInUsecase().call(event.email);
      emit(TimerChangedState(time: otpTimer));
    } on Failure catch (e) {
      _dialogAndSheetService.showAppDialog(StatusDialog(
          isError: true, title: "Error Signing In", body: e.message));
    }
  }

  FutureOr<void> _onPinFieldChangedEvent(
    PinFieldChangedEvent event,
    Emitter<VerifyEmailState> emit,
  ) {}

  Future<FutureOr<void>> _onVerifyEmailTapEvent(
    VerifyEmailTapEvent event,
    Emitter<VerifyEmailState> emit,
  ) async {
    try {
      emit(VerifyEmailLoadingState());
      await VerifyOtpUsecase().call(VerifyOtpParams(
        email: (newResponse ?? event.response).email.trim(),
        requestId: (newResponse ?? event.response).requestId.trim(),
        otp: event.otp.trim(),
      ));
      emit(VerifyEmailSuccessState());
    } on Failure catch (e) {
      emit(VerifyEmailErrorState());
      _dialogAndSheetService.showAppDialog(StatusDialog(
          isError: true, title: "Error Verifying OTP", body: e.message));
    } finally {
      emit(TimerFinishedState());
    }
  }

  FutureOr<void> _onChangeTimerEvent(
    ChangeTimerEvent event,
    Emitter<VerifyEmailState> emit,
  ) async {
    if (event.time == 0) {
      emit(TimerFinishedState());
      return;
    }
    await Future.delayed(const Duration(seconds: 1));
    emit(TimerChangedState(time: event.time - 1));
  }

  bool get isFirstTime => _authenticationRepo.isFirstTime;
}
