part of 'webview_bloc.dart';

abstract class WebviewEvent extends Equatable {
  const WebviewEvent();

  @override
  List<Object> get props => [];
}

class LoadUrlEvent extends WebviewEvent {
  final String link;
  const LoadUrlEvent(this.link);
  @override
  List<Object> get props => [link];
}
