import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/enums/_enums.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/services/_services.dart';

class FetchExploreUseCase with UseCases<void, NoParams> {
  final _locationService = locator<ILocationService>();
  final _placeRepository = locator<IPlaceRepository>();

  PaginatedData<PlaceModel>? exploreDetails;
  PaginatedData<CategoryModel>? categories;
  PaginatedData<PlaceModel>? recentlyAdded;
  PaginatedData<PlaceModel>? bestRatings;

  @override
  Future<void> call(NoParams params) async {
    final location = await _getLocation();
    await Future.wait([
      _placeRepository
          .fetchExploreDetails(location)
          .then((value) => exploreDetails = value),
      _placeRepository
          .fetchExploreCategories()
          .then((value) => categories = value),
      _placeRepository
          .fetchExploreByFilter(ExploreSearchEnum.recentlyAdded)
          .then((value) => recentlyAdded = value),
      _placeRepository
          .fetchExploreByFilter(ExploreSearchEnum.ratings)
          .then((value) => bestRatings = value),
    ]);
  }

  Future<AppLocation?> _getLocation() async {
    try {
      if (!(await _locationService.canGetLocation())) {
        final isGranted = await _locationService.requestPermission();
        if (!isGranted) {
          return null;
        }
      }
      if (!await _locationService.requestService()) return null;
      return await _locationService.getCurrentLocation();
    } on Failure {
      return null;
    }
  }

  Future<void> fetchCategories() async {
    await _placeRepository.fetchExploreCategories();
  }
}
