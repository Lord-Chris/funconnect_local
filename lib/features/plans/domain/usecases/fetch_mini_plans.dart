import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/data/repository/data_sources/plan_remote_data_source.dart';

class FetchMiniPlansUseCase with UseCases {
  final _remoteDS = PlansRemoteDataSource();
  @override
  Future call(params) {
    return _remoteDS.fetchUserMiniPlans();
  }
}
