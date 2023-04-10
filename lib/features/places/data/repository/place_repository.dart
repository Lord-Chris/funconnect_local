import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:funconnect/core/enums/_enums.dart';
import 'package:funconnect/core/models/app_location.dart';
import 'package:funconnect/core/models/paginated_data.dart';
import 'package:funconnect/features/places/data/data_sources/remote_places_data_source.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';
import 'package:funconnect/services/_services.dart';

import '../../../authentication/data/dto/user_model.dart';
import '../../domain/entities/place_model.dart';
import '../../domain/entities/search_query_param.dart';
import '../data_sources/local_data_source.dart';
import 'i_place_repository.dart';

class PlaceRepository extends IPlaceRepository {
  final _connectivityService = locator<IConnectivityService>();
  final _localStorageService = locator<ILocalStorageService>();
  final _remoteDS = RemotePlaceDataSource();
  final _localDS = LocalPlaceDataSource();

  PaginatedData<CategoryModel>? _categories;
  @override
  PaginatedData<CategoryModel>? get categories => _categories;

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
  Future<List<CategoryModel>> fetchUserInterests() async {
    final useRemote = await _connectivityService.checkInternetConnection();
    if (!useRemote) {
      return _localDS.fetchUserInterests();
    }
    final interests = await _remoteDS.fetchUserInterests();
    await _localStorageService.write(
      HiveKeys.userBoxId,
      key: StorageKeys.userInterests,
      data: interests.data.map((e) => e.toMap()).toList(),
    );
    return interests.data;
  }

  @override
  Future<PaginatedData<PlaceModel>> fetchPlacesByCategory(
      String categoryId, AppLocation? location) async {
    return await _remoteDS.fetchPlacesByCategory(categoryId, location);
  }

  @override
  Future<PaginatedData<PlaceModel>> searchPlaces(
      SearchQueryParam query, AppLocation? location) async {
    final res = await _remoteDS.searchPlaces(query, location);
    if (query.param.isNotEmpty) {
      final history = _getSearchHistory()..add(query.param);
      if (history.length >= 5) history.removeLast();

      _localStorageService.write(
        HiveKeys.placesBoxId,
        key: StorageKeys.searchHistory,
        data: history.toSet().toList(),
      );
    }
    return res;
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
  Future<bool> toggleBookmark(PlaceModel place, bool shouldBookmark) async {
    if (shouldBookmark) {
      await _remoteDS.bookmarkPlace(place.id);
      return true;
    } else {
      await _remoteDS.unBookmarkPlace(place.id);
      return false;
    }
  }

  @override
  Future<PaginatedData<PlaceModel>> fetchExploreDetails(
    AppLocation? location,
  ) async {
    return await _remoteDS.fetchExploreDetails(location);
  }

  @override
  Future<PaginatedData<CategoryModel>> fetchExploreCategories() async {
    _categories = await _remoteDS.fetchExploreCategories();
    return _categories!;
  }

  @override
  Future<PaginatedData<PlaceModel>> fetchExploreByFilter(
      ExploreSearchEnum filter) async {
    return await _remoteDS.fetchExploreByFilter(filter);
  }

  @override
  void removeHistory(String item) {
    final history = _getSearchHistory();
    history.remove(item);
    _localStorageService.write(HiveKeys.placesBoxId,
        key: StorageKeys.searchHistory, data: history);
  }

  @override
  UserModel get user {
    final data = _localStorageService
        .read<Map<String, dynamic>?>(HiveKeys.userBoxId, key: StorageKeys.user);
    return UserModel.fromMap(data!);
  }

  List<String> _getSearchHistory() =>
      _localStorageService.read(HiveKeys.placesBoxId,
          key: StorageKeys.searchHistory, def: []).cast<String>();

  @override
  List<String> get searchHistory => _getSearchHistory();
}
