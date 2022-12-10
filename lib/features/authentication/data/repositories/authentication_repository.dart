import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/authentication/data/data_sources/i_authentication_datasource.dart';
import 'package:funconnect/features/authentication/domain/params/email_sign_in.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';
import 'package:funconnect/models/api_response.dart';

import 'i_authentication_repository.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  final _httpDS = locator<IAuthenticationDataSource>();

  @override
  Future<ApiResponse<void>> signInWithApple(EmailSignInParams params) {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<void>> signInWithEmail(EmailSignInParams params) async {
    return await _httpDS.requestLoginOtp(params);
  }

  @override
  Future<ApiResponse<void>> signInWithGoogle(EmailSignInParams params) {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<void>> verifyOtp(VerifyOtpParams params) async {
    return await _httpDS.verifyOtp(params);
  }
}
