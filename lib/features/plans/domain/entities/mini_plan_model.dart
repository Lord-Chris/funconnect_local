import 'dart:convert';

import 'package:equatable/equatable.dart';

class MiniPlanModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final ReminderType reminderType;
  final ReminderMedium reminderMedium;
  final Scope scope;
  const MiniPlanModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.reminderType,
      required this.reminderMedium,
      required this.scope});

  MiniPlanModel copyWith(
      {String? id,
      String? name,
      String? description,
      ReminderType? reminderType,
      ReminderMedium? reminderMedium,
      Scope? scope}) {
    return MiniPlanModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        reminderType: reminderType ?? this.reminderType,
        reminderMedium: reminderMedium ?? this.reminderMedium,
        scope: scope ?? this.scope);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'reminder_type': reminderType.value});
    result.addAll({'reminder_medium': reminderMedium.value});
    result.addAll({'scope': scope.value});

    return result;
  }

  factory MiniPlanModel.fromMap(Map<String, dynamic> map) {
    return MiniPlanModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        reminderType: ReminderType.fromValue(map['reminder_type']),
        reminderMedium: ReminderMedium.fromValue(map['reminder_medium']),
        scope: Scope.fromValue(map['scope']));
  }

  String toJson() => json.encode(toMap());

  factory MiniPlanModel.fromJson(String source) =>
      MiniPlanModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MiniPlanModel(id: $id, name: $name, description: $description, reminderType: $reminderType, reminderMedium: $reminderMedium)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      reminderType,
      reminderMedium,
    ];
  }
}

enum ReminderType {
  oneHourBefore("one_hour_before"),
  thirtyMinutesBefore("thirty_minutes_before"),
  fifteenMinutesBefore("fifteen_minutes_before");

  const ReminderType(this.value);
  final String value;

  factory ReminderType.fromValue(String value) {
    switch (value) {
      case 'one_hour_before':
        return ReminderType.oneHourBefore;
      case 'thirty_minutes_before':
        return ReminderType.thirtyMinutesBefore;
      case 'fifteen_minutes_before':
        return ReminderType.fifteenMinutesBefore;
      default:
        return ReminderType.oneHourBefore;
    }
  }
}

enum ReminderMedium {
  google("google");

  const ReminderMedium(this.value);
  final String value;

  factory ReminderMedium.fromValue(String value) {
    switch (value) {
      case 'google':
        return ReminderMedium.google;
      default:
        return ReminderMedium.google;
    }
  }
}

enum Scope {
  owner("owner"),
  shared("shared");

  const Scope(this.value);
  final String value;

  factory Scope.fromValue(String value) {
    switch (value) {
      case 'owner':
        return Scope.owner;
      case 'shared':
        return Scope.shared;
      default:
        return Scope.owner;
    }
  }
}
