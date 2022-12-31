import 'package:funconnect/core/model/paginated_data.dart';
import 'package:funconnect/features/authentication/data/dto/interest_model.dart';
import 'package:funconnect/features/authentication/domain/params/email_sign_in.dart';
import 'package:funconnect/features/authentication/domain/params/profile_setup.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';
import 'package:funconnect/models/api_response.dart';

import '../dto/check_email_response.dart';
import '../dto/request_otp_response.dart';
import '../dto/user_model.dart';
import '../dto/verify_otp_response.dart';

abstract class IAuthenticationDataSource {
  Future<ApiResponse<CheckEmailResponse>> checkEmail(
    EmailSignInParams params,
  );

  Future<ApiResponse<RequestOtpResponse>> requestLoginOtp(
    EmailSignInParams params,
  );

  Future<ApiResponse<UserModel>> verifyOtp(
    VerifyOtpParams params,
  );

  Future<ApiResponse<VerifyOtpResponse>> loginWithGoogle(
    String token,
  );

  Future<ApiResponse<VerifyOtpResponse>> setUpProfile(
    ProfileSetupParam params,
  );

  Future<ApiResponse<PaginatedData<InterestModel>>> fetchInterests();
}
