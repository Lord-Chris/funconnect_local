import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/plans/data/data_sources/plan_remote_data_source.dart';
import 'package:funconnect/features/plans/data/repository/i_plans_repository.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_friend_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_place_model.dart';
import 'package:funconnect/features/plans/domain/params/add_friends.dart';
import 'package:funconnect/features/plans/domain/params/add_place.dart';

class PlansRepository extends IPlansRepository {
  final _remoteDS = PlansRemoteDataSource();
  @override
  Future<List<MiniPlanModel>> fetchUserMiniPlans() {
    return _remoteDS.fetchUserMiniPlans();
  }

  @override
  Future<MiniPlanModel> createMiniPlan(MiniPlanModel miniPlan) {
    return _remoteDS.createMiniPlan(miniPlan);
  }

  @override
  Future<MiniPlanFriend> addFriend(AddFriendsParams param) {
    return _remoteDS.addFriend(param);
  }

  @override
  Future<PaginatedData<MiniPlanFriend>> fetchMiniPlanFriends(String planId) {
    return _remoteDS.fetchMiniPlanFriends(planId);
  }

  @override
  Future<List<MiniPlanPlaceModel>> fetchMiniPlanPlaces(String planId) {
    return _remoteDS.fetchMiniPlanPlaces(planId);
  }

  @override
  Future<MiniPlanPlaceModel> addPlace(AddPlaceParams param) {
    return _remoteDS.addPlace(param);
  }
}
