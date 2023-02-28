import '../../../authentication/data/dto/user_model.dart';

abstract class IDashboardRepository {
  Future<UserModel> fetchUserProfile();
}
