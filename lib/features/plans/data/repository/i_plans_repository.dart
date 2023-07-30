import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_friend_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/domain/params/add_friends.dart';

abstract class IPlansRepository {
  Future<PaginatedData<MiniPlanModel>> fetchUserMiniPlans();
  Future<MiniPlanModel> createMiniPlan(MiniPlanModel miniPlan);
  Future<MiniPlanFriend> addFriend(AddFriendsParams param);
  Future<PaginatedData<MiniPlanFriend>> fetchMiniPlanFriends(String planId);
}
