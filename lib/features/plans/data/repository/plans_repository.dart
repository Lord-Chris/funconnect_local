import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/plans/data/repository/data_sources/plan_remote_data_source.dart';
import 'package:funconnect/features/plans/data/repository/i_plans_repository.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';

class PlansRepository extends IPlansRepository {
  final _remoteDS = PlansRemoteDataSource();
  @override
  Future<PaginatedData<MiniPlanModel>> fetchUserMiniPlans() {
    return _remoteDS.fetchUserMiniPlans();
  }

  @override
  Future<MiniPlanModel> createMiniPlan(MiniPlanModel miniPlan) {
    return _remoteDS.createMiniPlan(miniPlan);
  }
}
