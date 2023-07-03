import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/app_keys.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/repositories/_authentication_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../services/_services.dart';

class GoogleSignInUsecase with UseCases<UserModel?, NoParams> {
  final repo = locator<IAuthenticationRepository>();
  final _navigationService = locator<INavigationService>();
  final googleSignIn = GoogleSignIn(
    clientId: Platform.isAndroid
        ? AppKeys.googleSignClientIdAndroid
        : AppKeys.googleSignClientIdIos,
  );
  @override
  Future<UserModel?> call(NoParams params) async {
    try {
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
      if (res == null) return null;
      if (res.name.isEmpty || res.username.isEmpty || res.gender.isEmpty) {
        _navigationService.toNamed(
          Routes.profileSetupViewRoute,
          arguments: res,
        );
      } else {
        _navigationService.offAllNamed(Routes.dashboardViewRoute, (_) => false);
      }
      return res;
    } on PlatformException catch (e) {
      throw Failure(
        'Something went wrong',
        extraData: e.toString(),
      );
    } on TimeoutException catch (e) {
      throw Failure(
        'Connection Timed out',
        extraData: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut().timeout(const Duration(seconds: 30));
    }
  }
}
