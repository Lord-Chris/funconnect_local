import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabTapEvent extends DashboardEvent {
  final int index;

  TabTapEvent(this.index);

  @override
  List<Object?> get props => [index];
}
