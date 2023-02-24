import 'package:equatable/equatable.dart';

import '../../../../../core/models/_models.dart';

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

class DynamicLinkEvent extends DashboardEvent {
  final DeepLinkDataModel data;

  DynamicLinkEvent(this.data);

  @override
  List<Object?> get props => [data];
}
