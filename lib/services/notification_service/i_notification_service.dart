import '../../features/authentication/data/dto/user_model.dart';

abstract class INotificationService {
  void init();
  Future<void> setUser(UserModel user);
  Future<void> clearUser();
}
