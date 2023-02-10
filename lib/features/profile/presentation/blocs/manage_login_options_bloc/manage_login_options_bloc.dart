import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manage_login_options_event.dart';
part 'manage_login_options_state.dart';

class ManageLoginOptionsBloc extends Bloc<ManageLoginOptionsEvent, ManageLoginOptionsState> {
  ManageLoginOptionsBloc() : super(ManageLoginOptionsInitial()) {
    on<ManageLoginOptionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
