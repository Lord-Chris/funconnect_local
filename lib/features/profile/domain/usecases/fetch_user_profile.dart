import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';

class FetchUserProfile with UseCases<ProfileModel, NoParams> {
  final _profileRepository = locator<IProfileRepository>();


  @override
  Future<ProfileModel> call(NoParams params) async {
    return await _profileRepository.fetchProfile();
  }
}