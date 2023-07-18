import 'package:dio/dio.dart';

import '../../core/app/_app.dart';
import '../../features/authentication/domain/usecases/google_signin_usecase.dart';
import '../../shared/dialogs/_dialogs.dart';
import '../_services.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.data['message'] == 'Unauthenticated') {
      final navigationService = locator<INavigationService>();
      final dialogAndSheetService = locator<IDialogAndSheetService>();
      _logOut();
      navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
      dialogAndSheetService.showAppDialog(
        const StatusDialog(
          isError: true,
          title: "Session Expired",
          body: "Kindly log in again.",
        ),
      );
    }
    handler.reject(err);
  }

  Future<void> _logOut() async {
    final notificationService = locator<INotificationService>();
    GoogleSignInUsecase().signOut();
    await notificationService.clearUser();
  }
}
