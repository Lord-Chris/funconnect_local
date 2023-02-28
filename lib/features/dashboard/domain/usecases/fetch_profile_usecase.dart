import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/dashboard/data/repository/i_dashboard_repository.dart';

import '../../../authentication/data/dto/user_model.dart';

class FetchProfileUsecase with UseCases<UserModel, NoParams> {
  final _repo = locator<IDashboardRepository>();

  @override
  Future<UserModel> call(NoParams params) async {
    return await _repo.fetchUserProfile();
  }
}
