import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';

import '../../domain/params/email_sign_in.dart';

abstract class IAuthenticationRepository {
  Future<void> signInWithGoogle(EmailSignInParams params);
  Future<void> signInWithApple(EmailSignInParams params);
  Future<void> signInWithEmail(EmailSignInParams params);
  Future<void> verifyOtp(VerifyOtpParams params);
}
