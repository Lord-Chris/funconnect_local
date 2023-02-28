import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';

class UpdateUserProfile with UseCases<ProfileModel, ProfileModel> {
  final _profileRepository = locator<IProfileRepository>();


  @override
  Future<ProfileModel> call(ProfileModel params) async {
    await _profileRepository.updateUserProfile(params);
    return await _profileRepository.fetchUserProfile();
  }
}