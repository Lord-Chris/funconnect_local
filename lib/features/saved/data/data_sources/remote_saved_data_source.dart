import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/api_constants.dart';
import 'package:funconnect/core/mixins/_mixins.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/services/_services.dart';

import '../../../places/domain/entities/saved_place_model.dart';

class RemoteSavedPlaceDataSource with ApiMixin {
  final _networkService = locator<INetworkService>();

  Future<PaginatedData<SavedPlaceModel>> fetchUserSavedPlaces() async {
    final res = await _networkService.get(
      ApiConstants.savedPlaces,
      headers: headers,
    );
    return PaginatedData.fromMap(
      res.data['data'],
      (x) => SavedPlaceModel.fromMap(x),
    );
  }
}
