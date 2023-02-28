import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/mixins/api_mixin.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/services/_services.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../authentication/data/dto/user_model.dart';

class RemoteDashboardDataSource with ApiMixin {
  final _networkService = locator<INetworkService>();

  Future<ApiResponse<UserModel>> fetchUserProfile() async {
    final res = await _networkService.put(
      ApiConstants.profileSetup,
      headers: headers,
    );
    return ApiResponse(data: UserModel.fromMap(res.data["data"]));
  }
}
