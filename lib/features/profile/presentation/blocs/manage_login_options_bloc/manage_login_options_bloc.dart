import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_login_options_event.dart';
part 'manage_login_options_state.dart';

class ManageLoginOptionsBloc
    extends Bloc<ManageLoginOptionsEvent, ManageLoginOptionsState> {
  ManageLoginOptionsBloc() : super(ManageLoginOptionsInitial()) {
    on<ManageLoginOptionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
