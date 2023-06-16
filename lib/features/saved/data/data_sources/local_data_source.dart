import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/services/_services.dart';

import '../../../../core/models/_models.dart';
import '../../../places/domain/entities/saved_place_model.dart';

class LocalSavedPlaceDataSource {
  final _localStorageService = locator<ILocalStorageService>();

  PaginatedData<SavedPlaceModel> getUserSavedPlaces() {
    final data = _localStorageService.read(
      HiveKeys.placesBoxId,
      key: StorageKeys.userSavedPlaces,
    );

    return PaginatedData.fromMap(data, (e) => SavedPlaceModel.fromMap(e));
  }
}
