import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:funconnect/core/models/app_location.dart';
import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/places/data/data_sources/remote_places_data_source.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';
import 'package:funconnect/services/_services.dart';

import '../../../authentication/data/dto/user_model.dart';
import '../data_sources/local_data_source.dart';
import 'i_place_repository.dart';

class PlaceRepository extends IPlaceRepository {
  final _connectivityService = locator<IConnectivityService>();
  final _localStorageService = locator<ILocalStorageService>();
  final _remoteDS = RemotePlaceDataSource();
  final _localDS = LocalPlaceDataSource();

  @override
  Future<List<HomeTrendItemModel>> fetchHomeTrends(
      AppLocation? location) async {
    final useRemote = await _connectivityService.checkInternetConnection();
    if (!useRemote) {
      return _localDS.getHomeTrends();
    }
    final homeTrend = await _remoteDS.getHomeTrends(location);
    await _localStorageService.write(
      HiveKeys.placesBoxId,
      key: StorageKeys.homeTrends,
      data: homeTrend.map((e) => e.toMap()).toList(),
      // data: [
      //   (homeTrend[0] as HomeTrendItemModel<CategoryModel>).toMap(
      //     (e) => e.toMap(),
      //   ),
      //   (homeTrend[1] as HomeTrendItemModel<PlaceModel>).toMap(
      //     (e) => e.toMap(),
      //   ),
      //   (homeTrend[2] as HomeTrendItemModel<PlaceModel>).toMap(
      //     (e) => e.toMap(),
      //   ),
      // ],
    );
    return homeTrend;
  }

  @override
  Future<FullPlaceModel> fetchPlaceDetail(String placeId) async {
    return await _remoteDS.fetchPlaceDetail(placeId);
  }

  @override
  Future<PaginatedData<ReviewModel>> fetchPlaceReviews(String placeId) async {
    return await _remoteDS.fetchPlaceReviews(placeId);
  }

  @override
  Future<void> reviewPlace(String placeId, ReviewParam review) async {
    return await _remoteDS.reviewPlace(placeId, review);
  }

  @override
  UserModel get user {
    final data = _localStorageService
        .read<Map<String, dynamic>?>(HiveKeys.userBoxId, key: StorageKeys.user);
    return UserModel.fromMap(data!);
  }
}
