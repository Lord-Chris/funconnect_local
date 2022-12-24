import 'package:funconnect/features/authentication/domain/params/email_sign_in.dart';
import 'package:funconnect/features/authentication/domain/params/profile_setup.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';

import 'i_authentication_repository.dart';

class MockAuthenticationRepository extends IAuthenticationRepository {
  @override
  Future<void> signInWithApple(EmailSignInParams params) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> signInWithEmail(EmailSignInParams params) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> signInWithGoogle(String authCode) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> verifyOtp(VerifyOtpParams params) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> setUpProfile(ProfileSetupParam params) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
