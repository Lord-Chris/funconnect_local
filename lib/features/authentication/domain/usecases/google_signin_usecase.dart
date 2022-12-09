import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/models/failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInUsecase with UseCases<bool, NoParams> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: "");

  @override
  Future<bool> call(NoParams params) async {
    try {
      final acct = await _googleSignIn.signIn();
      if (acct == null) return false;
      return true;
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
