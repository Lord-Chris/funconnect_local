import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState());
}
