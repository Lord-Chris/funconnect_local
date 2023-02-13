import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/repositories/i_authentication_repository.dart';
import 'package:funconnect/features/authentication/domain/params/email_sign_in.dart';

import '../../data/dto/request_otp_response.dart';

class EmailSignInUsecase with UseCases<RequestOtpResponse, String> {
  final repo = locator<IAuthenticationRepository>();

  @override
  Future<RequestOtpResponse> call(String params) async {
    final data = EmailSignInParams(email: params);
    final res = await repo.signInWithEmail(data);
    return res;
  }
}
