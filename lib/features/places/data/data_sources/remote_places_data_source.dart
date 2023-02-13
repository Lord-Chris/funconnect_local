import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/api_constants.dart';
import 'package:funconnect/core/mixins/_mixins.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';
import 'package:funconnect/services/_services.dart';

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

  Future<FullPlaceModel> fetchPlaceDetail(String placeId) async {
    final res = await _networkService.get(
      ApiConstants.singlePlace(placeId),
      headers: headers,
    );
    return FullPlaceModel.fromMap(res.data['data']);
  }
}
