import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';
import 'package:funconnect/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:funconnect/features/authentication/presentation/blocs/verify_email_bloc/verify_email_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/verify_email_bloc/verify_email_state.dart';
import 'package:funconnect/models/failure.dart';
import 'package:funconnect/services/_services.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  VerifyEmailBloc() : super(VerifyEmailInitialState()) {
    on<ResendCodeEvent>(_onResendCodeEvent);
    on<PinFieldChangedEvent>(_onPinFieldChangedEvent);
    on<VerifyEmailTapEvent>(_onVerifyEmailTapEvent);
    on<ChangeTimerEvent>(_onChangeTimerEvent);
  }

  static const otpTimer = 10;
  final _navigationService = locator<INavigationService>();

  FutureOr<void> _onResendCodeEvent(
    ResendCodeEvent event,
    Emitter<VerifyEmailState> emit,
  ) {
    emit(TimerChangedState(time: otpTimer));
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
      await VerifyOtpUsecase()
          .call(VerifyOtpParams(email: event.email, otp: event.otp));
      _navigationService.toNamed(Routes.profileSetupViewRoute);
      emit(VerifyEmailSuccessState());
    } on Failure {
      emit(VerifyEmailErrorState());
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
}
