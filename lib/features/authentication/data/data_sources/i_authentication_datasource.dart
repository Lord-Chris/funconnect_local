import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';
import 'package:funconnect/models/api_response.dart';

import '../../domain/params/email_sign_in.dart';

abstract class IAuthenticationDataSource {
  Future<ApiResponse<void>> checkEmail(EmailSignInParams params);
  Future<ApiResponse<void>> requestLoginOtp(EmailSignInParams params);
  Future<ApiResponse<void>> loginWithOtp(VerifyOtpParams params);
}
