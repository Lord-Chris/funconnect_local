import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/api_constants.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/features/authentication/data/data_sources/i_authentication_datasource.dart';
import 'package:funconnect/features/authentication/data/dto/check_email_response.dart';
import 'package:funconnect/features/authentication/data/dto/request_otp_response.dart';
import 'package:funconnect/features/authentication/data/dto/user_model.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';
import 'package:funconnect/models/api_response.dart';
import 'package:funconnect/services/_services.dart';

import '../../domain/params/email_sign_in.dart';
import '../dto/verify_otp_response.dart';

class HttpAuthenticationDataSource extends IAuthenticationDataSource {
  final _networkService = locator<INetworkService>();
  final _localStorageService = locator<ILocalStorageService>();

  @override
  Future<ApiResponse<CheckEmailResponse>> checkEmail(
    EmailSignInParams params,
  ) async {
    final res = await _networkService.post(
      ApiConstants.checkEmail,
      body: params.toMap(),
    );
    return ApiResponse(data: CheckEmailResponse.fromMap(res.data));
  }

  @override
  Future<ApiResponse<RequestOtpResponse>> requestLoginOtp(
    EmailSignInParams params,
  ) async {
    final res = await _networkService.post(
      ApiConstants.requestOtp,
      body: params.toMap(),
    );
    return ApiResponse(data: RequestOtpResponse.fromMap(res.data));
  }

  @override
  Future<ApiResponse<UserModel>> verifyOtp(
    VerifyOtpParams params,
  ) async {
    final res = await _networkService.post(
      ApiConstants.loginWithOtp,
      body: params.toMap(),
    );
    await _localStorageService.write(
      HiveKeys.userBoxId,
      key: StorageKeys.token,
      data: res.data['api_token'],
    );
    return ApiResponse(data: UserModel.fromMap(res.data));
  }

  @override
  Future<ApiResponse<VerifyOtpResponse>> loginWithGoogle(String token) async {
    final body = {"code": token};
    final res = await _networkService.post(
      ApiConstants.loginWithGoogle,
      body: body,
    );
    return ApiResponse(data: VerifyOtpResponse.fromMap(res.data));
  }
}
