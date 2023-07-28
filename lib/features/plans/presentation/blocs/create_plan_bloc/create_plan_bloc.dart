import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/features/plans/domain/params/add_friends.dart';
import 'package:funconnect/features/plans/domain/usecases/add_plan_friends_usecase.dart';
import 'package:funconnect/features/plans/domain/usecases/create_plan_usecase.dart';
import 'package:funconnect/services/dialog_and_sheet_service/i_dialog_and_sheet_service.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';
import 'package:funconnect/shared/dialogs/_dialogs.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';

part 'create_plan_event.dart';
part 'create_plan_state.dart';

class CreatePlanBloc extends Bloc<CreatePlanEvent, CreatePlanState> {
  CreatePlanBloc() : super(CreatePlanInitial()) {
    on<CreatePlanEvent>((event, emit) {});
    on<AddFriendEvent>(_addFriendEvent);
    on<RemoveFriendEvent>(_removeFriendEvent);
    on<CreatePlanClickedEvent>(_createPlanClickedEvent);
    on<ChangeReminderMediumEvent>(_changeReminderMediumEvent);
    on<ChangeReminderTypeEvent>(_changeReminderTypeEvent);
  }
  List<String> friends = [];

  final _dialogAndSheetService = locator<IDialogAndSheetService>();

  final _navigation = locator<INavigationService>();

  ReminderMedium reminderMedium = ReminderMedium.google;

  ReminderType reminderType = ReminderType.oneHourBefore;

  FutureOr<void> _addFriendEvent(
      AddFriendEvent event, Emitter<CreatePlanState> emit) {
    emit(FriendAddedState(friends..add(event.friendEmail)));
  }

  FutureOr<void> _removeFriendEvent(
      RemoveFriendEvent event, Emitter<CreatePlanState> emit) {
    emit(FriendAddedState(friends..remove(event.friendEmail)));
  }

  FutureOr<void> _createPlanClickedEvent(
      CreatePlanClickedEvent event, Emitter<CreatePlanState> emit) async {
    emit(CreatedPlanLoadingState());
    try {
      final newPlan = MiniPlanModel(
        id: const Uuid().v4(),
        name: event.planName,
        description: event.planDescription,
        reminderMedium: reminderMedium,
        reminderType: reminderType,
        scope: Scope.owner,
      );

      final res = await CreatePlanUsecase().call(newPlan);

      if (friends.isNotEmpty) {
        for (String email in friends) {
          await AddFriendUseCase()
              .call(AddFriendsParams(email: email, miniPlanId: res.id));
        }
      }

      _dialogAndSheetService.showAppDialog(
        StatusDialog(
          isError: false,
          body: "${event.planName} plan has been created successfully",
          buttonLabel: "View Plans",
          buttonAction: () {
            _navigation.back();
            _navigation.back();
            _navigation.back();
          },
          hasButton: true,
        ),
      );
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  FutureOr<void> _changeReminderMediumEvent(
      ChangeReminderMediumEvent event, Emitter<CreatePlanState> emit) {
    reminderMedium = event.reminderMedium;
  }

  FutureOr<void> _changeReminderTypeEvent(
      ChangeReminderTypeEvent event, Emitter<CreatePlanState> emit) {
    reminderType = event.reminderType;
  }
}
