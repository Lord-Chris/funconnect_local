import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/authentication/data/dto/user_model.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';

abstract class IPlaceRepository {
  Future<List<HomeTrendItemModel>> fetchHomeTrends(AppLocation? location);
  Future<FullPlaceModel> fetchPlaceDetail(String placeId);
  Future<PaginatedData<ReviewModel>> fetchPlaceReviews(String placeId);
  Future<void> reviewPlace(String placeId, ReviewParam review);

  UserModel get user;
}
