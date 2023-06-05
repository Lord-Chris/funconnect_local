import 'dart:io';

import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/app_keys.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/repositories/_authentication_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInUsecase with UseCases<UserModel?, NoParams> {
  final repo = locator<IAuthenticationRepository>();
  final googleSignIn = GoogleSignIn(
    clientId: Platform.isAndroid
        ? AppKeys.googleSignClientIdAndroid
        : AppKeys.googleSignClientIdIos,
  );
  @override
  Future<UserModel?> call(NoParams params) async {
    try {
      if (await googleSignIn.isSignedIn()) await googleSignIn.signOut();
      final acct = await googleSignIn.signIn();
      if (acct == null) return null;
      if (acct.email.isEmpty) return null;

      UserModel? res;
      if (Platform.isAndroid) {
        res = await repo.signInWithGoogle(acct.serverAuthCode ?? "");
      } else {
        GoogleSignInAuthentication auth = await acct.authentication;
        if (auth.idToken == null) {
          throw const Failure('Google Sign in Failed');
        }
        res = await repo.signInWithGoogleIos(auth.idToken ?? "");
      }
      return res;
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
