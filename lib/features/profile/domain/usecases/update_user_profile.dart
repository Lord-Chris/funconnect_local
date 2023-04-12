import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';

import '../../../../core/models/_models.dart';

class UpdateUserProfile with UseCases<UserModel, UserModel> {
  final _profileRepository = locator<IProfileRepository>();

  @override
  Future<UserModel> call(UserModel params) async {
    await _profileRepository.updateUserProfile(params);
    return await _profileRepository.fetchUserProfile();
  }
}
