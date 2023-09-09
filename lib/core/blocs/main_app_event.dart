part of 'main_app_bloc.dart';

abstract class MainAppEvent extends Equatable {
  const MainAppEvent();

  @override
  List<Object> get props => [];
}

class InitializeMainApp extends MainAppEvent {}

class PlacesLoaded extends MainAppEvent {
  final HomeResponseData homeTrends;

  const PlacesLoaded(this.homeTrends);

  @override
  List<Object> get props => [homeTrends];
}
