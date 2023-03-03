import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/dashboard/data/repository/i_dashboard_repository.dart';
import 'package:funconnect/services/_services.dart';

import '../../../authentication/data/dto/user_model.dart';

class FetchProfileUsecase with UseCases<UserModel, NoParams> {
  final _repo = locator<IDashboardRepository>();
  final _notificationService = locator<INotificationService>();

  @override
  Future<UserModel> call(NoParams params) async {
    final user = await _repo.fetchUserProfile();
    await _notificationService.setUser(user);
    return user;
  }
}
