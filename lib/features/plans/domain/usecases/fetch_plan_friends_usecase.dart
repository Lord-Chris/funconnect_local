import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/data/repository/i_plans_repository.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_friend_model.dart';

class FetchPlanFriendsUsecase with UseCases {
  final _planRepository = locator<IPlansRepository>();
  @override
  Future<PaginatedData<MiniPlanFriend>> call(params) async {
    return await _planRepository.fetchMiniPlanFriends(params);
  }
}
