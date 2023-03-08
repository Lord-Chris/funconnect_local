import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/mixins/api_mixin.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/services/_services.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../authentication/data/dto/user_model.dart';
import '../../domain/entities/notification_model.dart';

class RemoteDashboardDataSource with ApiMixin {
  final _networkService = locator<INetworkService>();

  Future<ApiResponse<UserModel>> fetchUserProfile() async {
    final res = await _networkService.get(
      ApiConstants.profileSetup,
      headers: headers,
    );
    return ApiResponse(data: UserModel.fromMap(res.data["data"]));
  }

  Future<PaginatedData<NotificationModel>> fetchAllNotifications() async {
    final res = await _networkService.get(
      ApiConstants.notifications,
      headers: headers,
    );
    return PaginatedData.fromMap(
      res.data["data"],
      (e) => NotificationModel.fromMap(e),
    );
  }

  Future<void> readAllNotifications() async {
    await _networkService.post(
      ApiConstants.readAllNotification,
      headers: headers,
    );
  }
}
