import 'dart:io';

import 'package:dio/dio.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/api_constants.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/core/mixins/_mixins.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/authentication/data/data_sources/i_authentication_datasource.dart';
import 'package:funconnect/features/authentication/data/dto/check_email_response.dart';
import 'package:funconnect/features/authentication/data/dto/interest_model.dart';
import 'package:funconnect/features/authentication/data/dto/request_otp_response.dart';
import 'package:funconnect/features/authentication/domain/params/profile_setup.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';
import 'package:funconnect/services/_services.dart';

import '../../domain/params/email_sign_in.dart';
import '../dto/verify_otp_response.dart';

class HttpAuthenticationDataSource extends IAuthenticationDataSource
    with ApiMixin {
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
      data: res.data['data']['api_token'],
    );
    return ApiResponse(data: UserModel.fromMap(res.data['data']));
  }

  @override
  Future<ApiResponse<UserModel>> loginWithGoogle(String token) async {
    final body = {"code": token};
    final res = await _networkService.post(
      ApiConstants.loginWithGoogle,
      body: body,
    );
    await _localStorageService.write(
      HiveKeys.userBoxId,
      key: StorageKeys.token,
      data: res.data['data']['api_token'],
    );
    return ApiResponse(data: UserModel.fromMap(res.data));
  }

  @override
  Future<ApiResponse<VerifyOtpResponse>> loginWithApple(String token) async {
    await Future.delayed(const Duration(seconds: 2));
    return const ApiResponse(data: VerifyOtpResponse(email: true, message: ""));
  }

  @override
  Future<ApiResponse<UserModel>> setUpProfile(ProfileSetupParam params) async {
    final res = await _networkService.put(
      ApiConstants.profileSetup,
      headers: headers,
      body: params.toMap(),
    );
    return ApiResponse(data: UserModel.fromMap(res.data["data"]));
  }

  @override
  Future<ApiResponse<UserModel>> uploadProfileImage(File image) async {
    final res = await _networkService.post(
      ApiConstants.profileImage,
      headers: headers,
      body: FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path),
      }),
    );
    return ApiResponse(data: UserModel.fromMap(res.data["data"]));
  }

  @override
  Future<ApiResponse<PaginatedData<InterestModel>>> fetchInterests() async {
    final res = await _networkService.get(
      ApiConstants.categories,
      headers: headers,
    );

    return ApiResponse(
      data: PaginatedData<InterestModel>.fromMap(
        res.data['data'],
        (e) => InterestModel.fromMap(e),
      ),
    );
  }

  @override
  Future<void> saveInterests(List<InterestModel> interests) async {
    final body = {
      "categories": interests.map((e) => e.id).toList(),
    };
    await _networkService.post(ApiConstants.userInterests,
        headers: headers, body: body);
  }

  UserModel? get user {
    final data = _localStorageService.read<Map<String, dynamic>?>(
      HiveKeys.userBoxId,
      key: StorageKeys.userProfile,
    );

    if (data == null) return null;
    return UserModel.fromMap(data);
  }
}
