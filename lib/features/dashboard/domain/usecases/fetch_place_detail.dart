import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

class FetchPlaceDetail with UseCases<PlaceModel, String> {
  final _placeRepository = locator<IPlaceRepository>();

  @override
  Future<PlaceModel> call(String params) async {
    final details = await _placeRepository.fetchPlaceDetail(params);
    return PlaceModel.fromFullPlaceModel(details);
  }
}
