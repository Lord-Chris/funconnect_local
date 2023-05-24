import 'dart:io';

import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/app_keys.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/repositories/_authentication_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInUsecase with UseCases<UserModel?, NoParams> {
  // static const androidId =
  //     "72010274266-6drs994dl4a00k83jfbf6njtf6phtq4e.apps.googleusercontent.com";
  // static const iosId =
  //     "72010274266-vosimccjbt4dj700ots582hg6i5br0ft.apps.googleusercontent.com";

  final repo = locator<IAuthenticationRepository>();

  @override
  Future<UserModel?> call(NoParams params) async {
    try {
      final acct = await GoogleSignIn(
        clientId: Platform.isAndroid
            ? AppKeys.googleSignClientIdAndroid
            : AppKeys.googleSignClientIdIos,
      ).signIn();
      if (acct == null) return null;

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
