import 'package:funconnect/models/api_response.dart';

import '../../domain/params/email_sign_in.dart';

abstract class IAuthenticationRepository {
  Future<ApiResponse<void>> signInWithGoogle(EmailSignInParams params);
  Future<ApiResponse<void>> signInWithApple(EmailSignInParams params);
  Future<ApiResponse<void>> signInWithEmail(EmailSignInParams params);
}
