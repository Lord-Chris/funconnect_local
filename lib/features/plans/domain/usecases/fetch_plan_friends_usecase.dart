import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/data/repository/data_sources/plan_remote_data_source.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_friend_model.dart';

class FetchPlanFriendsUsecase with UseCases {
  final _remoteDS = PlansRemoteDataSource();
  @override
  Future<PaginatedData<MiniPlanFriend>> call(params) async {
    return await _remoteDS.fetchMiniPlanFriends(params);
  }
}
