import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/constants/api_constants.dart';
import 'package:funconnect/core/mixins/api_mixin.dart';
import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/plans/domain/entities/delete_mini_plan_response.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_friend_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_place_model.dart';
import 'package:funconnect/features/plans/domain/params/add_friends.dart';
import 'package:funconnect/features/plans/domain/params/add_place.dart';
import 'package:funconnect/services/network_service/i_network_service.dart';
import 'package:logger/logger.dart';

class PlansRemoteDataSource with ApiMixin {
  final _networkService = locator<INetworkService>();
  Future<List<MiniPlanModel>> fetchUserMiniPlans() async {
    final res = await _networkService.get(
      ApiConstants.miniPlans,
      headers: headers,
    );
    return res.data['data']
        .map<MiniPlanModel>((x) => MiniPlanModel.fromMap(x))
        .toList();
  }

  Future<MiniPlanModel> createMiniPlan(MiniPlanModel miniPlan) async {
    final res = await _networkService.post(
      ApiConstants.miniPlans,
      body: {
        "name": miniPlan.name,
        "description": miniPlan.description,
        "reminder_type": miniPlan.reminderType.value,
        "reminder_medium": miniPlan.reminderMedium.value,
      },
    );

    Logger().i(res.data['data']);
    return MiniPlanModel.fromMap(res.data['data']);
  }

  Future<MiniPlanFriend> addFriend(AddFriendsParams param) async {
    final res = await _networkService.post(
      ApiConstants.addFriends(param.miniPlanId),
      body: {
        "email": param.email,
      },
    );

    return MiniPlanFriend.fromMap(res.data['data']);
  }

  Future<PaginatedData<MiniPlanFriend>> fetchMiniPlanFriends(
      String miniPlanId) async {
    final res = await _networkService.get(
      ApiConstants.getFriends(miniPlanId),
      headers: headers,
    );
    return PaginatedData.fromMap(
        res.data['data'], (x) => MiniPlanFriend.fromMap(x));
  }

  Future<List<MiniPlanPlaceModel>> fetchMiniPlanPlaces(
      String miniPlanId) async {
    final res = await _networkService.get(
      ApiConstants.getMiniPlanPlaces(miniPlanId),
      headers: headers,
    );
    return res.data['data']
        .map<MiniPlanPlaceModel>((x) => MiniPlanPlaceModel.fromMap(x))
        .toList();
  }

  Future<MiniPlanPlaceModel> addPlace(AddPlaceParams param) async {
    try {
      final res = await _networkService.post(
        ApiConstants.addMiniPlanPlace(param.miniPlanId),
        body: {"place_id": param.placeId, "datetime": param.date},
        headers: headers,
      );

      return MiniPlanPlaceModel.fromMap(res.data['data']);
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }

  Future<DeleteMiniPlanResponse> deletePlan(String id) async {
    final res = await _networkService.delete(ApiConstants.deleteMiniPlan(id),
        headers: headers);

    return DeleteMiniPlanResponse.fromMap(res.data);
  }

  Future updateMiniPlan(AddPlaceParams params) async {
    final res = await _networkService.put(
      ApiConstants.updateMiniPlan(params.miniPlanId, params.placeId),
      body: {"place_id": params.placeId, "datetime": params.date},
      headers: headers,
    );
    return res.data['data'];
  }
}
