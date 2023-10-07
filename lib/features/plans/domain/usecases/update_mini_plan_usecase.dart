import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/data/repository/i_plans_repository.dart';

class UpdateMiniPlan with UseCases {
  final _planRepository = locator<IPlansRepository>();
  @override
  Future call(params) async {
    return await _planRepository.updatePlan(params);
  }
}
