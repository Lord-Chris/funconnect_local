part of 'home_v2_bloc.dart';

abstract class HomeV2Event extends Equatable {
  const HomeV2Event();

  @override
  List<Object> get props => [];
}

class HomeV2InitEvent extends HomeV2Event {}
