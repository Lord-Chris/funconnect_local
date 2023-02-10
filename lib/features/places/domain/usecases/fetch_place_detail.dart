import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

class FetchPlaceDetail with UseCases<FullPlaceModel, PlaceModel> {
  final _placeRepository = locator<IPlaceRepository>();

  @override
  Future<FullPlaceModel> call(PlaceModel params) async {
    return await _placeRepository.fetchPlaceDetail(params.id);
  }
}
