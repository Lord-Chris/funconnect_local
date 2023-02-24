import 'dart:convert';

import 'package:equatable/equatable.dart';

class DeepLinkDataModel extends Equatable {
  final String type; // place, event
  final String value;

  const DeepLinkDataModel({
    required this.type,
    required this.value,
  });

  const DeepLinkDataModel.place(this.value) : type = "place";
  const DeepLinkDataModel.event(this.value) : type = "event";

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'value': value,
    };
  }

  factory DeepLinkDataModel.fromMap(Map<String, dynamic> map) {
    return DeepLinkDataModel(
      type: map['type'] ?? '',
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DeepLinkDataModel.fromJson(String source) =>
      DeepLinkDataModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [type, value];
}
