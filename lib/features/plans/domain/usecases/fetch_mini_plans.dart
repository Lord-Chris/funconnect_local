import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/data/repository/data_sources/plan_remote_data_source.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';

class FetchMiniPlansUseCase with UseCases {
  final _remoteDS = PlansRemoteDataSource();
  @override
  Future<PaginatedData<MiniPlanModel>> call(params) {
    return _remoteDS.fetchUserMiniPlans();
  }
}
