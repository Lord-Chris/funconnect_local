import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/dashboard/data/repository/i_dashboard_repository.dart';
import 'package:funconnect/features/dashboard/domain/entities/notification_model.dart';

class FetchNotifications
    with UseCases<PaginatedData<NotificationModel>, NoParams> {
  final _repo = locator<IDashboardRepository>();

  @override
  Future<PaginatedData<NotificationModel>> call(NoParams params) async {
    return await _repo.fetchAllNotifications();
  }
}

class ReadAllNotifications
    with UseCases<PaginatedData<NotificationModel>, NoParams> {
  final _repo = locator<IDashboardRepository>();

  @override
  Future<PaginatedData<NotificationModel>> call(NoParams params) async {
    await _repo.readAllNotifications();
    return await _repo.fetchAllNotifications();
  }
}
