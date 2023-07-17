import 'package:funconnect/core/enums/_enums.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_trends_reponse.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';

import '../../domain/entities/search_query_param.dart';

abstract class IPlaceRepository {
  Future<List<CategoryModel>> fetchUserInterests();
  Future<HomeTrendsReponse?> fetchHomeTrends(AppLocation? location);
  Future<PaginatedData<PlaceModel>> fetchPlacesByCategory(
      String categoryId, int? page, AppLocation? location);
  Future<PaginatedData<PlaceModel>> searchPlaces(
      SearchQueryParam query, AppLocation? location);
  Future<FullPlaceModel> fetchPlaceDetail(String placeId);
  Future<PaginatedData<ReviewModel>> fetchPlaceReviews(String placeId);
  Future<void> reviewPlace(String placeId, ReviewParam review);
  Future<bool> toggleBookmark(PlaceModel place, bool shouldBookmark);

  Future<PaginatedData<PlaceModel>> fetchExploreDetails(AppLocation? location);
  Future<PaginatedData<CategoryModel>> fetchExploreCategories();
  Future<PaginatedData<PlaceModel>> fetchExploreByFilter(
      ExploreSearchEnum filter);
  Future<void> addToSearchHistory(String item);
  Future<void> removeHistory(String item);

  UserModel get user;
  PaginatedData<CategoryModel>? get categories;
  List<String> get searchHistory;
}
