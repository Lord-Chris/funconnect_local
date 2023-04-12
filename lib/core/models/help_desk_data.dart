import 'package:equatable/equatable.dart';

class HelpDeskData extends Equatable {
  final String title;
  final String body;

  const HelpDeskData({
    required this.title,
    required this.body,
  });

  @override
  List<Object> get props => [title, body];
}
