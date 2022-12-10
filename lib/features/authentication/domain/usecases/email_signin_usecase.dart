import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/repositories/i_authentication_repository.dart';
import 'package:funconnect/features/authentication/domain/params/email_sign_in.dart';

class EmailSignInUsecase with UseCases<bool, String> {
  final repo = locator<IAuthenticationRepository>();

  @override
  Future<bool> call(String params) async {
    final data = EmailSignInParams(email: params);
    await repo.signInWithEmail(data);
    return true;
  }
}
