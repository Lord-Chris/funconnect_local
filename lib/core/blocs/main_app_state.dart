part of 'main_app_bloc.dart';

abstract class MainAppState extends Equatable {
  const MainAppState();

  @override
  List<Object> get props => [];
}

class MainAppInitial extends MainAppState {}

class HomeTrendsLoadedState extends MainAppState {
  final HomeResponseData homeTrends;

  const HomeTrendsLoadedState({required this.homeTrends});
  @override
  List<Object> get props => [homeTrends];
}
