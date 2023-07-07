import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/home_category_new.dart';
import 'package:funconnect/features/places/domain/entities/home_place.dart';
import 'package:funconnect/features/places/domain/entities/home_trends_reponse.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/services/location_service/location_service_new.dart';
import 'package:geocoding/geocoding.dart';
import 'package:logger/logger.dart';

import '../../../domain/entities/place_model.dart';

part 'home_v2_event.dart';
part 'home_v2_state.dart';

class HomeV2Bloc extends Bloc<HomeV2Event, HomeV2State> {
  HomeV2Bloc() : super(HomeV2InitialState()) {
    on<HomeV2Event>((event, emit) {});
    on<HomeV2InitEvent>(_onHomeV2Init);
    on<NotificationTapEvent>(_onNotificationTapEvent);
    on<PlaceTapEvent>(_onPlaceTapEvent);
    on<CategoryTapEvent>(_onCategoryTapEvent);
    on<HomeV2InterestClickedEvent>(_onInterestClicked);
  }

  final _localStorageService = locator<ILocalStorageService>();
  final _placeRepository = locator<IPlaceRepository>();
  final _navigationService = locator<INavigationService>();
  final _locationServiceNew = LocationServiceNew();

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  AppLocation? _appLocation;
  AppLocation? get appLocation => _appLocation;

  FutureOr<void> _onHomeV2Init(
      HomeV2InitEvent event, Emitter<HomeV2State> emit) async {
    emit(HomeV2LoadingState());
    try {
      await getCurrentUser();
      await _locationServiceNew.determinePosition().then((value) async {
        if (value != null) {
          final place =
              await placemarkFromCoordinates(value.latitude, value.longitude);

          AppLocation? newAppLocation = AppLocation(
              address: place.first.name,
              city: place.first.locality,
              state: place.first.administrativeArea,
              country: place.first.country,
              lat: value.latitude,
              long: value.longitude);

          _appLocation = newAppLocation;
        }
      });

      HomeTrendsReponse response =
          await _placeRepository.fetchHomeTrendsNew(_appLocation);
      List<CategoryModel> interests =
          await _placeRepository.fetchUserInterests();
      List<HomeCategory> categories = response.data.categories;
      List<HomePlaces> places = response.data.places;
      emit(HomeV2LoadedState(
          categories: categories, places: places, interests: interests));
    } catch (e) {
      Logger().e(e.toString());
      emit(HomeV2ErrorState(message: e.toString()));
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      var userMap = _localStorageService.read(HiveKeys.userBoxId,
          key: StorageKeys.userProfile);
      UserModel? currentUser = UserModel.fromMap(userMap);
      _userModel = currentUser;
      return currentUser;
    } catch (e) {
      rethrow;
    }
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

  FutureOr<void> _onInterestClicked(
      HomeV2InterestClickedEvent event, Emitter<HomeV2State> emit) {
    emit(HomeV2InterestView(interestClicked: event.interestClicked));
  }
}
