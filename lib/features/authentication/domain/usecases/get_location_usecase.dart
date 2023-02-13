import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/app_location.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/services/_services.dart';

class GetLocationUseCase with UseCases<AppLocation?, NoParams> {
  final _locationService = locator<ILocationService>();

  @override
  Future<AppLocation?> call(NoParams params) async {
    if (!(await _locationService.canGetLocation())) {
      final isGranted = await _locationService.requestPermission();
      if (!isGranted) {
        return null;
      }
    }
    return await _locationService.getCurrentLocation();
  }
}
