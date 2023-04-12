import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/repositories/i_authentication_repository.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';
import 'package:funconnect/services/_services.dart';

class VerifyOtpUsecase with UseCases<void, VerifyOtpParams> {
  final _repo = locator<IAuthenticationRepository>();
  final _navigationService = locator<INavigationService>();

  @override
  Future<void> call(VerifyOtpParams params) async {
    final user = await _repo.verifyOtp(params);
    _navigationService.offNamed(
      Routes.emailVerifiedRoute,
      arguments: (user.username).isNotEmpty,
    );
  }
}
