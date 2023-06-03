import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';

import '../entities/login_options_model.dart';

class UpdateLoginOptions with UseCases<LoginOptionsModel, LoginOptionsData> {
  final _profileRepository = locator<IProfileRepository>();

  @override
  Future<LoginOptionsModel> call(LoginOptionsData params) async {
    return await _profileRepository.updateLogInOptions(params);
  }
}
