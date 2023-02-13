import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/services/_services.dart';

import '../entities/home_trend_item_model.dart';

class FetchHomeTrends with UseCases<List<HomeTrendItemModel>, NoParams> {
  final _locationService = locator<ILocationService>();
  final _placeRepository = locator<IPlaceRepository>();

  /// Switch to Records later
  @override
  Future<List<HomeTrendItemModel>> call(NoParams params) async {
    final location = await _getLocation();
    return await _placeRepository.fetchHomeTrends(location);
  }

  Future<AppLocation?> _getLocation() async {
    if (!(await _locationService.canGetLocation())) {
      final isGranted = await _locationService.requestPermission();
      if (!isGranted) {
        return null;
      }
    }
    return await _locationService.getCurrentLocation();
  }
}
