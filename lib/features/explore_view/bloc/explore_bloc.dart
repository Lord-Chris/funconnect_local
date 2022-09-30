import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/explore_view/bloc/explore_event.dart';
import 'package:funconnect/features/explore_view/bloc/explore_state.dart';
import 'package:funconnect/services/_services.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreInitialState());
  final _navigationService = locator<INavigationService>();
}
