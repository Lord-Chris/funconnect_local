

import 'package:funconnect/features/fun_connect/saved/domain/entities/saved_place_model.dart';

import '../../../../../core/models/paginated_data.dart';
import '../../../../authentication/data/dto/user_model.dart';

abstract class ISavedRepository {
  Future<PaginatedData<SavedPlaceModel>> fetchUserSavedPlaces(String userId);

  UserModel get user;
}
