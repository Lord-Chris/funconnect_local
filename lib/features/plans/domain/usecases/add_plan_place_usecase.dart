import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/plans/data/repository/i_plans_repository.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_place_model.dart';
import 'package:funconnect/features/plans/domain/params/add_place.dart';

class AddPlanPlaceUsecase with UseCases<MiniPlanPlaceModel, AddPlaceParams> {
  final _planRepository = locator<IPlansRepository>();
  @override
  Future<MiniPlanPlaceModel> call(params) async {
    return await _planRepository.addPlace(params);
  }
}
