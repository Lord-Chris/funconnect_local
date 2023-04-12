import '../../../../core/models/_models.dart';
import '../../../places/domain/entities/saved_place_model.dart';

abstract class ISavedRepository {
  Future<PaginatedData<SavedPlaceModel>> fetchUserSavedPlaces();

  UserModel get user;
}
