import '../../core/models/_models.dart';

abstract class INotificationService {
  void init();
  Future<void> setUser(UserModel user);
  Future<void> clearUser();
}
