import '../../../../core/models/paginated_data.dart';
import '../../../authentication/data/dto/user_model.dart';
import '../../../places/domain/entities/saved_place_model.dart';

abstract class ISavedRepository {
  Future<PaginatedData<SavedPlaceModel>> fetchUserSavedPlaces();

  UserModel get user;
}
