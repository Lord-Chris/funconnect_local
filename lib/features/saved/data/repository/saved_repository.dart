import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/_constants.dart';

import '../../../../core/models/_models.dart';
import '../../../../services/local_storage_service/i_local_storage_service.dart';
import '../../../places/domain/entities/saved_place_model.dart';
import '../data_sources/remote_saved_data_source.dart';
import 'i_saved_repository.dart';

class SavedRepository extends ISavedRepository {
  final _localStorageService = locator<ILocalStorageService>();
  final _remoteDS = RemoteSavedPlaceDataSource();

  @override
  Future<PaginatedData<SavedPlaceModel>> fetchUserSavedPlaces() async {
    return await _remoteDS.fetchUserSavedPlaces();
  }

  @override
  UserModel get user {
    final data = _localStorageService.read<Map<String, dynamic>?>(
      HiveKeys.userBoxId,
      key: StorageKeys.userProfile,
    );
    return UserModel.fromMap(data!);
  }
}
