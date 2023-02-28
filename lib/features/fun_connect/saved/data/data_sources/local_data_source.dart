import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/services/_services.dart';

import '../../../../places/domain/entities/place_model.dart';

class LocalSavedPlaceDataSource {
  final _localStorageService = locator<ILocalStorageService>();

  List<PlaceModel> getUserSavedPlaces() {
    final data = _localStorageService.read(
      HiveKeys.placesBoxId,
      key: StorageKeys.userSavedPlaces,
      def: [],
    );

    assert(data.length == 3);
    return data.map((e) => PlaceModel.fromMap(e)).toList();

   
  }
}
