import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';

abstract class IPlaceRepository {
  Future<List<HomeTrendItemModel> >fetchHomeTrends(AppLocation? location);
}
