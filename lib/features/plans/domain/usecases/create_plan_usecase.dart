import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/data/repository/i_plans_repository.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';

class CreatePlanUsecase with UseCases<MiniPlanModel, MiniPlanModel> {
  final _planRepository = locator<IPlansRepository>();
  @override
  Future<MiniPlanModel> call(params) async {
    return await _planRepository.createMiniPlan(params);
  }
}
