import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';

import '../../data/repositories/_authentication_repo.dart';
import '../params/profile_setup.dart';

class ProfileSetupUseCase with UseCases<void, ProfileSetupParam> {
  final _authenticationRepository = locator<IAuthenticationRepository>();
  @override
  Future<void> call(ProfileSetupParam params) async {
    await _authenticationRepository.setUpProfile(params);
  }
}
