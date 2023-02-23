import 'package:funconnect/core/enums/_enums.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/authentication/data/dto/user_model.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';

abstract class IPlaceRepository {
  Future<List<CategoryModel>> fetchUserInterests();
  Future<List<HomeTrendItemModel>> fetchHomeTrends(AppLocation? location);
  Future<PaginatedData<PlaceModel>> fetchPlacesByCategory(String categoryId);
  Future<FullPlaceModel> fetchPlaceDetail(String placeId);
  Future<PaginatedData<ReviewModel>> fetchPlaceReviews(String placeId);
  Future<void> reviewPlace(String placeId, ReviewParam review);

  Future<PaginatedData<PlaceModel>> fetchExploreDetails(AppLocation? location);
  Future<PaginatedData<CategoryModel>> fetchExploreCategories();
  Future<PaginatedData<PlaceModel>> fetchExploreByFilter(
      ExploreSearchEnum filter);

  UserModel get user;
}
