import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/repositories/_authentication_repo.dart';
import 'package:logger/logger.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInUsecase with UseCases<UserModel?, NoParams> {
  final repo = locator<IAuthenticationRepository>();
  final _logger = Logger();

  @override
  Future<UserModel?> call(NoParams params) async {
    try {
      _logger.i(">>> Starting Apple Login");
      final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'app.funconnect.auth.',
            redirectUri: Uri.parse('https://website.com/apple/callback'),
          ));
      _logger.i(">>> Apple Login Credentials Gotten");
      if ((credential.authorizationCode).isEmpty) return null;
      final user = await repo.signInWithApple(credential.authorizationCode);
      _logger.i(">>> Apple Login Credentials Verified");
      return user;
    } on SignInWithAppleException catch (e) {
      throw Failure("Apple Sign in failed", extraData: e.toString());
    }
  }
}
