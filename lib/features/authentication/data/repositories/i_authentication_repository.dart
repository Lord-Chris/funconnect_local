import '../../domain/params/email_sign_in.dart';
import '../../domain/params/profile_setup.dart';
import '../../domain/params/verify_otp.dart';

abstract class IAuthenticationRepository {
  Future<void> signInWithGoogle(EmailSignInParams params);
  Future<void> signInWithApple(EmailSignInParams params);
  Future<void> signInWithEmail(EmailSignInParams params);
  Future<void> verifyOtp(VerifyOtpParams params);
  Future<void> setUpProfile(ProfileSetupParam params);
}
