import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';

abstract class IPlansRepository {
  Future<PaginatedData<MiniPlanModel>> fetchUserMiniPlans();
  Future<MiniPlanModel> createMiniPlan(MiniPlanModel miniPlan);
}
