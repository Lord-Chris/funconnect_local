import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/authentication/data/dto/user_model.dart';
import 'package:funconnect/features/dashboard/data/data_sources/remote_data_source.dart';
import 'package:funconnect/features/dashboard/data/repository/i_dashboard_repository.dart';

import '../../../../core/constants/_constants.dart';
import '../../../../services/_services.dart';

class DashboardRepository extends IDashboardRepository {
  final _remoteDS = RemoteDashboardDataSource();
  final _localStorageService = locator<ILocalStorageService>();

  @override
  Future<UserModel> fetchUserProfile() async {
    final res = await _remoteDS.fetchUserProfile();
    await _localStorageService.write(
      HiveKeys.userBoxId,
      key: StorageKeys.user,
      data: res.data.toMap(),
    );
    return res.data;
  }
}
