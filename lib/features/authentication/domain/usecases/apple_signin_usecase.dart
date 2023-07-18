import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/repositories/_authentication_repo.dart';
import 'package:logger/logger.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../services/_services.dart';

class AppleSignInUsecase with UseCases<UserModel?, NoParams> {
  final repo = locator<IAuthenticationRepository>();
  final _navigationService = locator<INavigationService>();
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
        ),
      );
      _logger.i(">>> Apple Login Credentials Gotten");
      if ((credential.authorizationCode).isEmpty) return null;
      // _logger.d(credential.authorizationCode);
      // return null;
      final user = await repo.signInWithApple(credential.authorizationCode);
      _logger.i(">>> Apple Login Credentials Verified");
      if (user == null) return null;
      if (user.name.isEmpty || user.username.isEmpty || user.gender.isEmpty) {
        _navigationService.toNamed(
          Routes.profileSetupViewRoute,
          arguments: user,
        );
      } else {
        _navigationService.offAllNamed(Routes.dashboardViewRoute, (_) => false);
      }
      return user;
    } on SignInWithAppleException catch (e) {
      if (e is SignInWithAppleAuthorizationException) {
        if (e.code == AuthorizationErrorCode.canceled) return null;
      }
      throw Failure("Apple Sign in failed", extraData: e.toString());
    }
  }
}
