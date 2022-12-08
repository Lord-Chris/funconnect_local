import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/api_constants.dart';
import 'package:funconnect/features/authentication/domain/params/email_sign_in.dart';
import 'package:funconnect/models/api_response.dart';
import 'package:funconnect/services/_services.dart';

import 'i_authentication_repository.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  final _networkService = locator<INetworkService>();

  @override
  Future<ApiResponse<void>> signInWithApple(EmailSignInParams params) {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<void>> signInWithEmail(EmailSignInParams params) async {
    await _networkService.post(ApiConstants.requestOtp, body: params.toMap());
    return const ApiResponse<void>(data: null);
  }

  @override
  Future<ApiResponse<void>> signInWithGoogle(EmailSignInParams params) {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
