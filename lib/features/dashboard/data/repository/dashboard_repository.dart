import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/dashboard/data/data_sources/remote_data_source.dart';
import 'package:funconnect/features/dashboard/data/repository/i_dashboard_repository.dart';

import '../../../../core/constants/_constants.dart';
import '../../../../core/models/_models.dart';
import '../../../../services/_services.dart';
import '../../domain/entities/notification_model.dart';

class DashboardRepository extends IDashboardRepository {
  final _remoteDS = RemoteDashboardDataSource();
  final _localStorageService = locator<ILocalStorageService>();

  @override
  Future<UserModel> fetchUserProfile() async {
    final res = await _remoteDS.fetchUserProfile();
    await _localStorageService.write(
      HiveKeys.userBoxId,
      key: StorageKeys.userProfile,
      data: res.data.toMap(),
    );
    return res.data;
  }

  @override
  Future<PaginatedData<NotificationModel>> fetchAllNotifications() async {
    final res = await _remoteDS.fetchAllNotifications();
    await _localStorageService.write(
      HiveKeys.userBoxId,
      key: StorageKeys.notifications,
      data: res.toMap((e) => e.toMap()),
    );
    return res;
  }

  @override
  Future<void> readAllNotifications() async {
    return await _remoteDS.readAllNotifications();
  }
}
