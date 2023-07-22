import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/constants/api_constants.dart';
import 'package:funconnect/core/mixins/api_mixin.dart';
import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/services/network_service/i_network_service.dart';
import 'package:logger/logger.dart';

class PlansRemoteDataSource with ApiMixin {
  final _networkService = locator<INetworkService>();
  Future<PaginatedData<MiniPlanModel>> fetchUserMiniPlans() async {
    final res = await _networkService.get(
      ApiConstants.miniPlans,
      headers: headers,
    );
    Logger().i("Mini Plans Response: ${res.data}");
    return PaginatedData.fromMap(
        res.data['data'], (x) => MiniPlanModel.fromMap(x));
  }
}
