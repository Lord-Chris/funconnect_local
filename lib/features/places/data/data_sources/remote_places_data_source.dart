import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/api_constants.dart';
import 'package:funconnect/core/enums/_enums.dart';
import 'package:funconnect/core/mixins/_mixins.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';
import 'package:funconnect/services/_services.dart';

import '../../domain/entities/place_model.dart';
import '../../domain/entities/review_model.dart';
import '../../domain/entities/saved_place_model.dart';

class RemotePlaceDataSource with ApiMixin {
  final _networkService = locator<INetworkService>();

  Future<List<HomeTrendItemModel>> getHomeTrends(AppLocation? location) async {
    final res = await _networkService.get(
      ApiConstants.homeTrends(location),
      headers: headers,
    );
    final data = res.data['data'] as List;
    assert(data.length == 3);
    return data.map((e) => HomeTrendItemModel.fromMap(e)).toList();
    // return [
    //   HomeTrendItemModel.fromMap(data[0], (e) => CategoryModel.fromMap(e)),
    //   HomeTrendItemModel.fromMap(data[1], (e) => PlaceModel.fromMap(e)),
    //   HomeTrendItemModel.fromMap(data[2], (e) => PlaceModel.fromMap(e)),
    // ];
  }

  Future<PaginatedData<PlaceModel>> fetchPlacesByCategory(
      String categoryId, AppLocation? location) async {
    final res = await _networkService.get(
      ApiConstants.categoryPlaces(categoryId, location),
      headers: headers,
    );
    return PaginatedData.fromMap(
        res.data['data'], (x) => PlaceModel.fromMap(x));
  }

  Future<FullPlaceModel> fetchPlaceDetail(String placeId) async {
    final res = await _networkService.get(
      ApiConstants.singlePlace(placeId),
      headers: headers,
    );
    return FullPlaceModel.fromMap(res.data['data']);
  }

  Future<PaginatedData<ReviewModel>> fetchPlaceReviews(String placeId) async {
    final res = await _networkService.get(
      ApiConstants.placeReview(placeId),
      headers: headers,
    );
    return PaginatedData.fromMap(
        res.data['data'], (x) => ReviewModel.fromMap(x));
  }

  Future<void> reviewPlace(String placeId, ReviewParam review) async {
    await _networkService.post(
      ApiConstants.placeReview(placeId),
      headers: headers,
      body: review.toBody(),
    );
  }

  Future<PaginatedData<PlaceModel>> fetchExploreDetails(
    AppLocation? location,
  ) async {
    final res = await _networkService.get(
      ApiConstants.explore(location),
      headers: headers,
    );
    return PaginatedData.fromMap(
        res.data['data']['near_places'], (x) => PlaceModel.fromMap(x));
  }

  Future<PaginatedData<CategoryModel>> fetchExploreCategories() async {
    final res = await _networkService.get(
      ApiConstants.exploreFilter(ExploreSearchEnum.categories),
      headers: headers,
    );
    return PaginatedData.fromMap(
        res.data['data'], (x) => CategoryModel.fromMap(x));
  }

  Future<PaginatedData<PlaceModel>> fetchExploreByFilter(
      ExploreSearchEnum filter) async {
    final res = await _networkService.get(
      ApiConstants.exploreFilter(filter),
      headers: headers,
    );
    if (filter == ExploreSearchEnum.ratings) {
      return PaginatedData.fromMap(
          res.data['data'], (x) => PlaceModel.fromMap(x['place']));
    }
    return PaginatedData.fromMap(
        res.data['data'], (x) => PlaceModel.fromMap(x));
  }

  Future<PaginatedData<CategoryModel>> fetchUserInterests() async {
    final res = await _networkService.get(
      ApiConstants.userInterests,
      headers: headers,
    );
    return PaginatedData.fromMap(
        res.data['data'], (x) => CategoryModel.fromMap(x['category']));
  }

  Future<SavedPlaceModel> bookmarkPlace(FullPlaceModel place) async {
    final res = await _networkService.post(
      ApiConstants.bookmarkPlace(place.id),
      headers: headers,
    );

    return SavedPlaceModel.fromMap(res.data['data']);
  }

  Future<void> unBookmarkPlace(SavedPlaceModel place) async {
    await _networkService.post(
      ApiConstants.unBookmarkPlace(place.id),
      headers: headers,
    );
  }
}
