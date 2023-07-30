import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/data/repository/i_plans_repository.dart';

import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';

class FetchMiniPlansUseCase
    with UseCases<PaginatedData<MiniPlanModel>, NoParams> {
  final _planRepository = locator<IPlansRepository>();
  @override
  Future<PaginatedData<MiniPlanModel>> call(params) async {
    return await _planRepository.fetchUserMiniPlans();
  }
}
