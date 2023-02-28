import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/notification_bloc/notification_event.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/notification_bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationLoadingState());
}
