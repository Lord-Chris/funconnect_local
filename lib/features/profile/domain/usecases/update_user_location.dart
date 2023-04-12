import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';

class UpdateUserLocation with UseCases<UserModel, AppLocation> {
  final _profileRepository = locator<IProfileRepository>();

  @override
  Future<UserModel> call(AppLocation params) async {
    await _profileRepository.updateUserLocation(params);
    return await _profileRepository.fetchUserProfile();
  }
}
