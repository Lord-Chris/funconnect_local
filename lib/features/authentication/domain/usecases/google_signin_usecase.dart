import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/repositories/i_authentication_repository.dart';
import 'package:funconnect/features/authentication/domain/params/email_sign_in.dart';
import 'package:funconnect/models/failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInUsecase with UseCases<bool, NoParams> {
  final repo = locator<IAuthenticationRepository>();

  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: "");

  @override
  Future<bool> call(NoParams params) async {
    try {
      final acct = await _googleSignIn.signIn();
      if (acct == null) return false;
      final data = EmailSignInParams(email: acct.email);
      await repo.signInWithEmail(data);
      return true;
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
