import 'package:funconnect/core/app/locator.dart';

import 'package:funconnect/core/usecases/usecase.dart';

import 'package:funconnect/features/plans/data/repository/i_plans_repository.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_place_model.dart';

class FetchPlanPlacesUsecase with UseCases<List<MiniPlanPlaceModel>, String> {
  final _plansRepository = locator<IPlansRepository>();
  @override
  Future<List<MiniPlanPlaceModel>> call(params) async {
    return await _plansRepository.fetchMiniPlanPlaces(params);
  }
}
