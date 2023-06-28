import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/services/_services.dart';

part 'home_v2_event.dart';
part 'home_v2_state.dart';

class HomeV2Bloc extends Bloc<HomeV2Event, HomeV2State> {
  HomeV2Bloc() : super(HomeV2InitialState()) {
    on<HomeV2Event>((event, emit) {});
    on<HomeV2InitEvent>(_onHomeV2Init);
  }

  final _localStorageService = locator<ILocalStorageService>();
  final _locationService = locator<ILocationService>();
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  AppLocation? _appLocation;

  AppLocation? get appLocation => _appLocation;

  FutureOr<void> _onHomeV2Init(
      HomeV2InitEvent event, Emitter<HomeV2State> emit) async {
    emit(HomeV2LoadingState());
    try {} catch (e) {}
    await getCurrentUser();
    await _locationService.canGetLocation().then((value) {
      _locationService.requestPermission().then((value) async {
        var currentLocation = await _locationService.getCurrentLocation();
        _appLocation = currentLocation;
      });
    });
  }

  Future getCurrentUser() async {
    var userMap = _localStorageService.read(HiveKeys.userBoxId,
        key: StorageKeys.userProfile);
    UserModel? currentUser = UserModel.fromMap(userMap);
    _userModel = currentUser;
  }
}