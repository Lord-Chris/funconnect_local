import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';

import '../../../../services/location_service/i_location_service.dart';
import '../entities/place_model.dart';

class FetchPlacesByCategory {
  final _placeRepository = locator<IPlaceRepository>();
  final _locationService = locator<ILocationService>();

  Future<PaginatedData<PlaceModel>> call(String params, [int? page]) async {
    // "97f837d4-be25-4dd0-8b69-25270968d41d"
    final places = await _placeRepository.fetchPlacesByCategory(
      params,
      page,
      _locationService.userLocation,
    );
    return places;
  }
}
