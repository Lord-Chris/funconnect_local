import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/authentication/data/data_sources/i_authentication_datasource.dart';
import 'package:funconnect/features/authentication/domain/params/email_sign_in.dart';
import 'package:funconnect/features/authentication/domain/params/profile_setup.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';

import 'i_authentication_repository.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  final _httpDS = locator<IAuthenticationDataSource>();

  @override
  Future<void> signInWithApple(EmailSignInParams params) {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmail(EmailSignInParams params) async {
    await _httpDS.requestLoginOtp(params);
  }

  @override
  Future<void> signInWithGoogle(String authCode) async {
    await _httpDS.loginWithGoogle(authCode);
  }

  @override
  Future<void> verifyOtp(VerifyOtpParams params) async {
    await _httpDS.verifyOtp(params);
  }

  @override
  Future<void> setUpProfile(ProfileSetupParam params) {
    // TODO: implement setUpProfile
    throw UnimplementedError();
  }
}
