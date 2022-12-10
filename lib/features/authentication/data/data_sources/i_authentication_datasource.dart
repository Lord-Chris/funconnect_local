import 'package:funconnect/features/authentication/domain/params/email_sign_in.dart';
import 'package:funconnect/models/api_response.dart';

import '../models/check_email_response.dart';
import '../models/request_otp_response.dart';

abstract class IAuthenticationDataSource {
  Future<ApiResponse<CheckEmailResponse>> checkEmail(
    EmailSignInParams params,
  );

  Future<ApiResponse<RequestOtpResponse>> requestLoginOtp(
    EmailSignInParams params,
  );
}
