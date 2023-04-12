import '../../../../core/models/_models.dart';
import '../../domain/entities/notification_model.dart';

abstract class IDashboardRepository {
  Future<UserModel> fetchUserProfile();
  Future<PaginatedData<NotificationModel>> fetchAllNotifications();
  Future<void> readAllNotifications();
}
