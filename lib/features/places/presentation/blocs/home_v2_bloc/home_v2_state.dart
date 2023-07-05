part of 'home_v2_bloc.dart';

abstract class HomeV2State extends Equatable {
  const HomeV2State();

  @override
  List<Object> get props => [];
}

class HomeV2InitialState extends HomeV2State {}

class HomeV2LoadingState extends HomeV2State {}

class HomeV2ErrorState extends HomeV2State {
  final String message;

  const HomeV2ErrorState({this.message = "An error occured"});

  @override
  List<Object> get props => [message];
}

class HomeV2LoadedState extends HomeV2State {
  final List<HomeCategory> categories;
  final List<HomePlaces> places;
  final List<CategoryModel> interests;

  const HomeV2LoadedState(
      {required this.categories,
      required this.places,
      required this.interests});
}

class HomeV2InterestClicked extends HomeV2State {
  final CategoryModel interestClicked;

  const HomeV2InterestClicked({required this.interestClicked});
}
