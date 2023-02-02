import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_event.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_state.dart';

class PlaceDetailBloc extends Bloc<PlaceDetailEvent, PlaceDetailState> {
  PlaceDetailBloc() : super(InitialPlaceDetailState());
}
