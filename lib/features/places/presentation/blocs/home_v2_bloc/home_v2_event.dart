part of 'home_v2_bloc.dart';

abstract class HomeV2Event extends Equatable {
  const HomeV2Event();

  @override
  List<Object> get props => [];
}

class HomeV2InitEvent extends HomeV2Event {}

class NotificationTapEvent extends HomeV2Event {}

class PlaceTapEvent extends HomeV2Event {
  final HomePlacesData place;

  const PlaceTapEvent({required this.place});
}

class HomeV2RefreshEvent extends HomeV2Event {}

class CategoryTapEvent extends HomeV2Event {
  final HomeCategoryData category;

  const CategoryTapEvent({
    required this.category,
  });
}
