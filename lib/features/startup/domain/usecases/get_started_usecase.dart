import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/services/_services.dart';

class GetStartedUseCase with UseCases<void, NoParams> {
  final _localStorageService = locator<ILocalStorageService>();
  @override
  Future<void> call(NoParams params) async {
    await _localStorageService.write(
      HiveKeys.appBoxId,
      key: StorageKeys.showOnboarding,
      data: false,
    );
  }
}
