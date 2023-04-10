import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';

import '../entities/place_model.dart';
import '../entities/search_query_param.dart';

class SearchPlaces with UseCases<PaginatedData<PlaceModel>, SearchQueryParam> {
  final _placeRepository = locator<IPlaceRepository>();
  // final _localStorageService = locator<ILocalStorageService>();
  SearchQueryParam? param;

  @override
  Future<PaginatedData<PlaceModel>> call(SearchQueryParam params) async {
    final places = await _placeRepository.searchPlaces(params, null);
    param = params;
    return places;
  }

  Future<void> removeHistory(String item) async {
    await _placeRepository.removeHistory(item);
  }

  List<String> get searchHistory => _placeRepository.searchHistory;
}
