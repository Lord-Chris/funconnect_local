import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'place_detail_v2_event.dart';
part 'place_detail_v2_state.dart';

class PlaceDetailV2Bloc extends Bloc<PlaceDetailV2Event, PlaceDetailV2State> {
  PlaceDetailV2Bloc() : super(PlaceDetailV2Initial()) {
    on<PlaceDetailV2Event>((event, emit) {
      // TODO: implement event handler
    });
  }
}
