import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';

class FetchPlaceDetail with UseCases<List, String> {
  final _placeRepository = locator<IPlaceRepository>();

  @override
  Future<List> call(String params) async {
    // "97f837d4-be25-4dd0-8b69-25270968d41d"
    final details = await _placeRepository.fetchPlaceDetail(params);
    final reviews = await _placeRepository.fetchPlaceReviews(params);
    return [details, reviews];
  }
}
