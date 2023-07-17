import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:funconnect/core/enums/_enums.dart';
import 'package:funconnect/features/places/data/data_sources/remote_places_data_source.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_trends_reponse.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';
import 'package:funconnect/services/_services.dart';

import '../../../../core/models/_models.dart';
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
  Future<HomeTrendsReponse?> fetchHomeTrends(AppLocation? location) async {
    final useRemote = await _connectivityService.checkInternetConnection();
    if (!useRemote) {
      return _localDS.getHomeTrendsNew();
    }

    final homeTrendsnew = await _remoteDS.getHomeTrends(location);
    await _localStorageService.write(
      HiveKeys.placesBoxId,
      key: StorageKeys.homeTrends,
      data: homeTrendsnew.toMap(),
    );
    return homeTrendsnew;
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
      String categoryId, int? page, AppLocation? location) async {
    return await _remoteDS.fetchPlacesByCategory(categoryId, page, location);
  }

  @override
  Future<PaginatedData<PlaceModel>> searchPlaces(
      SearchQueryParam query, AppLocation? location) async {
    final res = await _remoteDS.searchPlaces(query, location);
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
  Future<void> addToSearchHistory(String item) async {
    final history = _getSearchHistory()..add(item);
    if (history.length >= 5) history.removeAt(0);
    await _localStorageService.write(
      HiveKeys.placesBoxId,
      key: StorageKeys.searchHistory,
      data: history.toSet().toList(),
    );
  }

  @override
  Future<void> removeHistory(String item) async {
    final history = _getSearchHistory();
    history.remove(item);
    await _localStorageService.write(HiveKeys.placesBoxId,
        key: StorageKeys.searchHistory, data: history);
  }

  @override
  UserModel get user {
    final data = _localStorageService.read<Map<String, dynamic>?>(
      HiveKeys.userBoxId,
      key: StorageKeys.userProfile,
    );
    return UserModel.fromMap(data!);
  }

  List<String> _getSearchHistory() =>
      _localStorageService.read(HiveKeys.placesBoxId,
          key: StorageKeys.searchHistory, def: []).cast<String>();

  @override
  List<String> get searchHistory => _getSearchHistory();
}
