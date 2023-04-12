import '../../../../core/models/_models.dart';
import '../../domain/params/email_sign_in.dart';
import '../../domain/params/profile_setup.dart';
import '../../domain/params/verify_otp.dart';
import '../dto/interest_model.dart';
import '../dto/request_otp_response.dart';

abstract class IAuthenticationRepository {
  Future<void> signInWithGoogle(String authCode);
  Future<void> signInWithApple(String code, String idToken);
  Future<RequestOtpResponse> signInWithEmail(EmailSignInParams params);
  Future<UserModel> verifyOtp(VerifyOtpParams params);
  Future<void> setUpProfile(ProfileSetupParam params);
  Future<PaginatedData<InterestModel>> fetchInterests();
  Future<void> saveInterests(List<InterestModel> interests);

  bool get isFirstTime;
}
