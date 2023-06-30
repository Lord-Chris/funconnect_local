import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/home_category_data.dart';
import 'package:funconnect/features/places/domain/entities/home_category_new.dart';
import 'package:funconnect/features/places/domain/entities/home_place.dart';
import 'package:funconnect/features/places/domain/entities/home_places_data.dart';
import 'package:funconnect/features/places/domain/entities/home_trends_reponse.dart';
import 'package:funconnect/services/_services.dart';
import 'package:logger/logger.dart';

part 'home_v2_event.dart';
part 'home_v2_state.dart';

class HomeV2Bloc extends Bloc<HomeV2Event, HomeV2State> {
  HomeV2Bloc() : super(HomeV2InitialState()) {
    on<HomeV2Event>((event, emit) {});
    on<HomeV2InitEvent>(_onHomeV2Init);
    on<NotificationTapEvent>(_onNotificationTapEvent);
    on<PlaceTapEvent>(_onPlaceTapEvent);
    on<CategoryTapEvent>(_onCategoryTapEvent);
  }

  final _localStorageService = locator<ILocalStorageService>();
  final _locationService = locator<ILocationService>();
  final _placeRepository = locator<IPlaceRepository>();
  final _navigationService = locator<INavigationService>();
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  AppLocation? _appLocation;

  AppLocation? get appLocation => _appLocation;

  FutureOr<void> _onHomeV2Init(
      HomeV2InitEvent event, Emitter<HomeV2State> emit) async {
    emit(HomeV2LoadingState());
    try {
      await getCurrentUser();
      await _locationService.requestPermission();
      var appLocation = await _locationService.getCurrentLocation();
      Logger().i(appLocation?.parsedAddress ?? "Didnt manage to get address");
      _appLocation = appLocation;
      HomeTrendsReponse response =
          await _placeRepository.fetchHomeTrendsNew(appLocation);
      List<HomeCategory> categories = response.data.categories;
      List<HomePlaces> places = response.data.places;
      emit(HomeV2LoadedState(categories: categories, places: places));
    } catch (e) {
      emit(HomeV2ErrorState(message: e.toString()));
    }
  }

  Future getCurrentUser() async {
    var userMap = _localStorageService.read(HiveKeys.userBoxId,
        key: StorageKeys.userProfile);
    UserModel? currentUser = UserModel.fromMap(userMap);
    _userModel = currentUser;
  }

  FutureOr<void> _onNotificationTapEvent(
      NotificationTapEvent event, Emitter<HomeV2State> emit) {
    _navigationService.toNamed(Routes.notificationsViewRoute);
  }

  FutureOr<void> _onPlaceTapEvent(
      PlaceTapEvent event, Emitter<HomeV2State> emit) async {
    await _navigationService.toNamed(Routes.placeDetailCopyRoute,
        arguments: event.place);
  }

  FutureOr<void> _onCategoryTapEvent(
      CategoryTapEvent event, Emitter<HomeV2State> emit) {
    _navigationService.toNamed(Routes.categoryDetailRoute, arguments: {
      'categoryId': event.category.id,
      'categoryName': event.category.name
    });
  }
}
