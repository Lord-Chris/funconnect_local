import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/utils/general_utils.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';
import 'package:funconnect/features/places/domain/usecases/bookmark_place.dart';
import 'package:funconnect/features/places/domain/usecases/review_place.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_event.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:funconnect/shared/dialogs/coming_soon_dialog.dart';
import 'package:logger/logger.dart';

import '../../../domain/usecases/fetch_place_detail.dart';

class PlaceDetailBloc extends Bloc<PlaceDetailEvent, PlaceDetailState> {
  PlaceDetailBloc() : super(PlaceDetailFetchingState()) {
    on<PlaceInitEvent>(_onPlaceInitEvent);
    on<ReviewPlaceEvent>(_onReviewPlaceEvent);
    on<PlaceTapEvent>(_onPlaceTapEvent);
    on<AddressTapEvent>(_onAddressTapEvent);
    on<PhoneTapEvent>(_onPhoneTapEvent);
    on<ShareTapEvent>(_onShareTapEvent);
    on<BookRideEvent>(_onBookRideEvent);
    on<BookmarkTapEvent>(_onBookmarkTapEvent);
  }
  final _logger = Logger();
  final _navigationService = locator<INavigationService>();
  final _dynamicLinkService = locator<IDynamicLinkService>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();
  String? link;

  Future<void> _getLink(PlaceModel place) async {
    try {
      link = await _dynamicLinkService.generateLink(
          desc: place.name,
          data: DeepLinkDataModel.place(place.id),
          image: place.coverImagePath);
    } on Failure catch (e) {
      _logger.e(e);
    }
  }

  Future<FutureOr<void>> _onPlaceInitEvent(
    PlaceInitEvent event,
    Emitter<PlaceDetailState> emit,
  ) async {
    try {
      _getLink(event.place);
      final data = await FetchPlaceDetail().call(event.place);
      emit(PlaceDetailIdleState(
        place: data[0] as FullPlaceModel,
        reviewsData: data[1] as PaginatedData<ReviewModel>,
      ));
    } on Failure catch (e) {
      _logger.e(e);
      emit(PlaceDetailFailureState(failure: e));
    }
  }

  FutureOr<void> _onReviewPlaceEvent(
    ReviewPlaceEvent event,
    Emitter<PlaceDetailState> emit,
  ) async {
    if (!event.isValid) return null;
    if (state is! PlaceDetailIdleState) return null;
    final prevState = state as PlaceDetailIdleState;
    try {
      final data = await ReviewPlaceUseCase(prevState.place.id)
          .call(event.toReviewParam());
      emit(PlaceDetailIdleState(
        place: prevState.place,
        reviewsData: data,
      ));
    } on Failure catch (e) {
      _logger.e(e);
      emit(prevState);
    }
  }

  FutureOr<void> _onPlaceTapEvent(
    PlaceTapEvent event,
    Emitter<PlaceDetailState> emit,
  ) {
    _navigationService.toNamed(Routes.placeDetailRoute, arguments: event.place);
  }

  FutureOr<void> _onAddressTapEvent(
    AddressTapEvent event,
    Emitter<PlaceDetailState> emit,
  ) {
    GeneralUtils.openUrl(event.uri);
  }

  FutureOr<void> _onPhoneTapEvent(
    PhoneTapEvent event,
    Emitter<PlaceDetailState> emit,
  ) {
    GeneralUtils.openUrl(event.uri);
  }

  FutureOr<void> _onShareTapEvent(
    ShareTapEvent event,
    Emitter<PlaceDetailState> emit,
  ) async {
    if (link == null) {
      await _getLink(event.place);
    }
    _dynamicLinkService.shareLink(link!);
  }

  FutureOr<void> _onBookRideEvent(
    BookRideEvent event,
    Emitter<PlaceDetailState> emit,
  ) {
    _dialogAndSheetService.showAppDialog(
      const ComingSoonDialog(
        icon: AppAssets.bookRideSvg,
        label: "Book a ride!",
      ),
    );
  }

  FutureOr<void> _onBookmarkTapEvent(
    BookmarkTapEvent event,
    Emitter<PlaceDetailState> emit,
  ) async {
    if (state is! PlaceDetailIdleState) return null;
    final prevState = state as PlaceDetailIdleState;
    try {
      final data = await BookmarkPlace().call(prevState.place);
      emit(prevState.copyWith(place: data));
    } on Failure catch (e) {
      _logger.e(e);
      emit(prevState);
    }
  }
}
