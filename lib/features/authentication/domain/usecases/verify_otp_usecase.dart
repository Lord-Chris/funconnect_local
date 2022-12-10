import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/repositories/i_authentication_repository.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';

class VerifyOtpUsecase with UseCases<void, VerifyOtpParams> {
  final _repo = locator<IAuthenticationRepository>();

  @override
  Future<void> call(VerifyOtpParams params) async {
    await _repo.verifyOtp(params);
  }
}
