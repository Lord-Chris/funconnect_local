import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';
import 'package:funconnect/services/_services.dart';

class LogoutUser with UseCases<void, NoParams> {
  final _profileRepository = locator<IProfileRepository>();
  final _notificationService = locator<INotificationService>();
  final _navigationService = locator<INavigationService>();

  @override
  Future<void> call(NoParams params) async {
    await _profileRepository.logout();
    await _notificationService.clearUser();
    _navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
  }
}
