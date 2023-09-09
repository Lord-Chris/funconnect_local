import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/data/repository/i_plans_repository.dart';
import 'package:funconnect/features/plans/domain/entities/delete_mini_plan_response.dart';

class DeletePlanUseCase with UseCases<DeleteMiniPlanResponse, String> {
  final _planRepository = locator<IPlansRepository>();
  @override
  Future<DeleteMiniPlanResponse> call(params) async {
    return await _planRepository.deletePlan(params);
  }
}
