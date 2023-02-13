import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

class FetchPlaceDetail with UseCases<List, PlaceModel> {
  final _placeRepository = locator<IPlaceRepository>();

  @override
  Future<List> call(PlaceModel params) async {
    // "97f837d4-be25-4dd0-8b69-25270968d41d"
    final details = await _placeRepository.fetchPlaceDetail(params.id);
    final reviews = await _placeRepository.fetchPlaceReviews(params.id);
    return [details, reviews];
  }
}
