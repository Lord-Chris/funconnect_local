import 'package:funconnect/core/models/app_location.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';

import 'i_place_repository.dart';

class PlaceRepository extends IPlaceRepository {
  @override
  Future<List<HomeTrendItemModel>> fetchHomeTrends(AppLocation? location) {
    // TODO: implement fetchHomeTrends
    throw UnimplementedError();
  }
}
