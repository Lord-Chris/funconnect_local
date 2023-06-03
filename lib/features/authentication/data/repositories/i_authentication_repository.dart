import '../../../../core/models/_models.dart';
import '../../domain/params/email_sign_in.dart';
import '../../domain/params/profile_setup.dart';
import '../../domain/params/verify_otp.dart';
import '../dto/interest_model.dart';
import '../dto/request_otp_response.dart';

abstract class IAuthenticationRepository {
  Future<UserModel?> signInWithGoogle(String authCode);
  Future<UserModel?> signInWithGoogleIos(String idToken);
  Future<UserModel?> signInWithApple(String code);
  Future<RequestOtpResponse> signInWithEmail(EmailSignInParams params);
  Future<UserModel> verifyOtp(VerifyOtpParams params);
  Future<void> setUpProfile(ProfileSetupParam params);
  Future<PaginatedData<InterestModel>> fetchInterests();
  Future<void> saveInterests(List<InterestModel> interests);

  bool get isFirstTime;
}
