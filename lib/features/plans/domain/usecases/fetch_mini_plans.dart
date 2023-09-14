import 'package:funconnect/core/app/locator.dart';

import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/data/repository/i_plans_repository.dart';

import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';

class FetchMiniPlansUseCase
    with UseCases<(List<MiniPlanModel>, List<MiniPlanModel>), NoParams> {
  final _planRepository = locator<IPlansRepository>();
  @override
  Future<(List<MiniPlanModel>, List<MiniPlanModel>)> call(params) async {
    List<MiniPlanModel> allMiniPlans =
        await _planRepository.fetchUserMiniPlans();

    List<MiniPlanModel> ownerPlans = [];

    List<MiniPlanModel> sharedPlans = [];

    for (var miniPlan in allMiniPlans) {
      if (miniPlan.scope == Scope.owner) {
        ownerPlans.add(miniPlan);
      } else {
        sharedPlans.add(miniPlan);
      }
    }

    return (ownerPlans, sharedPlans);
  }
}
