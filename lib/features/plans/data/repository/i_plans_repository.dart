import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_friend_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_place_model.dart';
import 'package:funconnect/features/plans/domain/params/add_friends.dart';
import 'package:funconnect/features/plans/domain/params/add_place.dart';
import 'package:funconnect/features/plans/domain/params/update_mini_plan_params.dart';

abstract class IPlansRepository {
  Future<List<MiniPlanModel>> fetchUserMiniPlans();
  Future<MiniPlanModel> createMiniPlan(MiniPlanModel miniPlan);
  Future<MiniPlanFriend> addFriend(AddFriendsParams param);
  Future<PaginatedData<MiniPlanFriend>> fetchMiniPlanFriends(String planId);
  Future<List<MiniPlanPlaceModel>> fetchMiniPlanPlaces(String planId);
  Future<MiniPlanPlaceModel> addPlace(AddPlaceParams param);
  Future deletePlan(String id);
  Future updatePlan(UpdateMiniPlanParams param);
}
