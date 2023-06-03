import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';
import 'package:funconnect/features/profile/domain/entities/login_options_model.dart';

class FetchLoginOptions with UseCases<LoginOptionsModel, NoParams> {
  final _profileRepository = locator<IProfileRepository>();

  @override
  Future<LoginOptionsModel> call(NoParams params) async {
    return await _profileRepository.fetchLogInOptions();
  }

  LoginOptionsModel get loginOptions => _profileRepository.loginOptions;
}
