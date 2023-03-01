import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';

class DeleteUserAccount with UseCases<void, NoParams> {
  final _profileRepository = locator<IProfileRepository>();

  @override
  Future<void> call(NoParams params) async {
    return await _profileRepository.deleteAccount();
  }
}
