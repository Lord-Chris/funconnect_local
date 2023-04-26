import 'dart:io';

import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/app_keys.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/repositories/_authentication_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInUsecase with UseCases<bool, NoParams> {
  static const androidId =
      "72010274266-6drs994dl4a00k83jfbf6njtf6phtq4e.apps.googleusercontent.com";
  static const iosId =
      "72010274266-vosimccjbt4dj700ots582hg6i5br0ft.apps.googleusercontent.com";

  final repo = locator<IAuthenticationRepository>();
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(clientId: Platform.isAndroid ? androidId : iosId);

  @override
  Future<bool> call(NoParams params) async {
    try {
      final acct =
          await GoogleSignIn(clientId: AppKeys.googleSignClientId).signIn();
      if (acct == null) return false;
      //GoogleSignInAuthentication? auth = await acct.authentication;
      //if (auth.idToken == null) null;
      await repo.signInWithGoogle(acct.serverAuthCode ?? "");
      return true;
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
