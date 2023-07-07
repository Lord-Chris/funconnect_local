import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/services/_services.dart';

import '../entities/category_model.dart';
import '../entities/home_response_data.dart';

class FetchHomeTrends with UseCases<void, NoParams> {
  final _locationService = locator<ILocationService>();
  final _placeRepository = locator<IPlaceRepository>();

  List<CategoryModel> interests = [];
  HomeResponseData? homeTrends;

  /// Switch to Records later
  @override
  Future<void> call(NoParams params) async {
    final location = await _getLocation();
    await Future.wait(
      [
        _placeRepository
            .fetchHomeTrendsNew(location)
            .then((value) => homeTrends = value.data),
        _placeRepository
            .fetchUserInterests()
            .then((value) => interests = value),
      ],
    );
  }

  Future<AppLocation?> _getLocation() async {
    try {
      if (!(await _locationService.canGetLocation())) {
        final isGranted = await _locationService.requestPermission();
        if (!isGranted) return null;
      }
      if (!await _locationService.requestService()) return null;
      return await _locationService.getCurrentLocation();
    } on Failure {
      return null;
    }
  }
}
