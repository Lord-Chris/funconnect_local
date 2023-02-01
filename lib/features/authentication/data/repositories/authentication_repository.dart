import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/core/models/paginated_data.dart';
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
  Future<void> signInWithApple(EmailSignInParams params) {
    // TODO: implement signInWithApple
    throw UnimplementedError();
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
    return res.data;
  }

  @override
  Future<void> setUpProfile(ProfileSetupParam params) async {
    final res = await _httpDS.setUpProfile(params);

    await _localStorageService.write(
      HiveKeys.userBoxId,
      key: StorageKeys.user,
      data: res.data.toMap(),
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
