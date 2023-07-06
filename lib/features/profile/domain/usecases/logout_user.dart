import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';
import 'package:funconnect/services/_services.dart';

import '../../../authentication/domain/usecases/google_signin_usecase.dart';

class LogoutUser with UseCases<void, NoParams> {
  final _profileRepository = locator<IProfileRepository>();
  final _notificationService = locator<INotificationService>();

  @override
  Future<void> call(NoParams params) async {
    GoogleSignInUsecase().signOut();
    await _profileRepository.logout();
    await _notificationService.clearUser();
  }
}
