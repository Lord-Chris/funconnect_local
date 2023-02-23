import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  final int navBarIndex;
  const DashboardState(
    this.navBarIndex,
  );
  @override
  List<Object?> get props => [navBarIndex];
}

class DashboardIdleState extends DashboardState {
  const DashboardIdleState(super.navBarIndex);
}
