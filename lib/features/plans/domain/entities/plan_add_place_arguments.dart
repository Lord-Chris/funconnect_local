import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_place_model.dart';

class PLanAddPLaceArguments {
  final MiniPlanModel plan;
  final MiniPlanPlaceModel? selectedPlace;
  final FullPlaceModel? place;
  final String? placeIdentifierId;

  PLanAddPLaceArguments(
      {this.placeIdentifierId,
      this.place,
      required this.plan,
      this.selectedPlace});
}
