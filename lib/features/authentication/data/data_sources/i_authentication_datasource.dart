import 'package:funconnect/features/authentication/domain/params/email_sign_in.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';
import 'package:funconnect/models/api_response.dart';

import '../dto/check_email_response.dart';
import '../dto/request_otp_response.dart';
import '../dto/verify_otp_response.dart';

abstract class IAuthenticationDataSource {
  Future<ApiResponse<CheckEmailResponse>> checkEmail(
    EmailSignInParams params,
  );

  Future<ApiResponse<RequestOtpResponse>> requestLoginOtp(
    EmailSignInParams params,
  );

  Future<ApiResponse<VerifyOtpResponse>> verifyOtp(
    VerifyOtpParams params,
  );

  Future<ApiResponse<VerifyOtpResponse>> loginWithGoogle(
    String token,
  );
}
