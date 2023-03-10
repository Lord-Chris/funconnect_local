import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:funconnect/features/fun_connect/saved/data/data_sources/local_data_source.dart';
import 'package:funconnect/features/fun_connect/saved/domain/entities/saved_place_model.dart';

import '../../../../../core/models/paginated_data.dart';
import '../../../../../services/connectivity_service/i_connectivity_service.dart';
import '../../../../../services/local_storage_service/i_local_storage_service.dart';
import '../../../../authentication/data/dto/user_model.dart';
import '../data_sources/remote_saved_data_source.dart';
import 'i_saved_repository.dart';


class SavedRepository extends ISavedRepository {
  final _connectivityService = locator<IConnectivityService>();
  final _localStorageService = locator<ILocalStorageService>();
  final _remoteDS = RemoteSavedPlaceDataSource();
  final _localDS = LocalSavedPlaceDataSource();


  @override
  Future<PaginatedData<SavedPlaceModel>> fetchUserSavedPlaces(
      String userId) async {
    return await _remoteDS.fetchUserSavedPlaces(userId);
  }

  @override
  UserModel get user {
    final data = _localStorageService
        .read<Map<String, dynamic>?>(HiveKeys.userBoxId, key: StorageKeys.user);
    return UserModel.fromMap(data!);
  }
}

