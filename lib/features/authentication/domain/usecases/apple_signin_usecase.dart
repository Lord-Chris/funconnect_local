import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/models/failure.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInUsecase with UseCases<bool, NoParams> {
  @override
  Future<bool> call(NoParams params) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      if ((credential.email ?? "").isEmpty) return false;
      return true;
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
