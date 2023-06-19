part of 'webview_bloc.dart';

abstract class WebviewState extends Equatable {
  const WebviewState();

  @override
  List<Object> get props => [];
}

class WebviewInitial extends WebviewState {}

class WebviewLoaded extends WebviewState {
  final WebViewController controller;
  const WebviewLoaded(this.controller);
  @override
  List<Object> get props => [controller];
}
