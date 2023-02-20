import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';

import '../entities/place_model.dart';

class FetchPlacesByCategory
    with UseCases<PaginatedData<PlaceModel>, CategoryModel> {
  final _placeRepository = locator<IPlaceRepository>();

  @override
  Future<PaginatedData<PlaceModel>> call(CategoryModel params) async {
    // "97f837d4-be25-4dd0-8b69-25270968d41d"
    final places = await _placeRepository.fetchPlacesByCategory(params.id);
    return places;
  }
}