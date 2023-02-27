import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';
import 'package:funconnect/services/_services.dart';

import '../../domain/entities/category_model.dart';

class LocalPlaceDataSource {
  final _localStorageService = locator<ILocalStorageService>();

  List<HomeTrendItemModel> getHomeTrends() {
    final data = _localStorageService.read(
      HiveKeys.placesBoxId,
      key: StorageKeys.homeTrends,
      def: [],
    );

    assert(data.length == 3);
    return data.map((e) => HomeTrendItemModel.fromMap(e)).toList();

    // return [
    //   HomeTrendItemModel.fromMap(data[0], (e) => CategoryModel.fromMap(e)),
    //   HomeTrendItemModel.fromMap(data[1], (e) => PlaceModel.fromMap(e)),
    //   HomeTrendItemModel.fromMap(data[2], (e) => PlaceModel.fromMap(e)),
    // ];
  }

  List<CategoryModel> fetchUserInterests() {
    final data = _localStorageService.read(
      HiveKeys.userBoxId,
      key: StorageKeys.userInterests,
      def: [],
    );
    return data.map((e) => CategoryModel.fromMap(e)).toList();
  }
}
