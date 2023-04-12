import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';

class FetchUserProfile with UseCases<UserModel, NoParams> {
  final _profileRepository = locator<IProfileRepository>();

  @override
  Future<UserModel> call(NoParams params) async {
    return await _profileRepository.fetchUserProfile();
  }
}
