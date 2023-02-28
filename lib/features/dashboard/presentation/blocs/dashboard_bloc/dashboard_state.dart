import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
  @override
  List<Object?> get props => [];
}

class DashboardIdleState extends DashboardState {
  final int navBarIndex;
  const DashboardIdleState(this.navBarIndex);
  @override
  List<Object?> get props => [navBarIndex];
}

class LinkLoadingState extends DashboardState {
  const LinkLoadingState();
}
