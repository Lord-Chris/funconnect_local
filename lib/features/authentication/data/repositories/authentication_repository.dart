import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/authentication/data/data_sources/i_authentication_datasource.dart';
import 'package:funconnect/features/authentication/data/dto/interest_model.dart';
import 'package:funconnect/features/authentication/data/dto/user_model.dart';
import 'package:funconnect/features/authentication/domain/params/email_sign_in.dart';
import 'package:funconnect/features/authentication/domain/params/profile_setup.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';
import 'package:funconnect/services/_services.dart';

import '../dto/request_otp_response.dart';
import 'i_authentication_repository.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  final _httpDS = locator<IAuthenticationDataSource>();
  final _localStorageService = locator<ILocalStorageService>();

  @override
  Future<void> signInWithApple(String code, String idToken) async {
    await _httpDS.loginWithApple(code);
  }

  @override
  Future<RequestOtpResponse> signInWithEmail(EmailSignInParams params) async {
    final res = await _httpDS.requestLoginOtp(params);
    return res.data;
  }

  @override
  Future<void> signInWithGoogle(String authCode) async {
    await _httpDS.loginWithGoogle(authCode);
  }

  @override
  Future<UserModel> verifyOtp(VerifyOtpParams params) async {
    final res = await _httpDS.verifyOtp(params);
    await _localStorageService.write(
      HiveKeys.userBoxId,
      key: StorageKeys.user,
      data: res.data.toMap(),
    );
    await _localStorageService.write(
      HiveKeys.appBoxId,
      key: StorageKeys.isFirstTime,
      data: false,
    );
    return res.data;
  }

  @override
  Future<void> setUpProfile(ProfileSetupParam params) async {
    final res = await _httpDS.setUpProfile(params);
    ApiResponse<UserModel>? res2;
    if (params.profilePhoto != null) {
      res2 = await _httpDS.uploadProfileImage(params.profilePhoto!);
    }

    await _localStorageService.write(
      HiveKeys.userBoxId,
      key: StorageKeys.user,
      data: (res2 ?? res).data.toMap(),
    );
  }

  @override
  Future<PaginatedData<InterestModel>> fetchInterests() async {
    final res = await _httpDS.fetchInterests();
    return res.data;
  }

  @override
  bool get isFirstTime => _localStorageService.read(HiveKeys.appBoxId,
      key: StorageKeys.isFirstTime, def: true);
}
