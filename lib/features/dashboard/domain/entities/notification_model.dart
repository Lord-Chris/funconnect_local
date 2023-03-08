import 'dart:convert';

import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String id;
  final String type;
  final String notifiableType;
  final String notifiableId;
  final NotificationData data;
  final String? readAt;
  final String createdAt;
  final String updatedAt;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.data,
    this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'notifiable_type': notifiableType,
      'notifiable_id': notifiableId,
      'data': data.toMap(),
      'read_at': readAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      notifiableType: map['notifiable_type'] ?? '',
      notifiableId: map['notifiable_id'] ?? '',
      data: NotificationData.fromMap(map['data']),
      readAt: map['read_at'],
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      id,
      type,
      notifiableType,
      notifiableId,
      data,
      createdAt,
      updatedAt,
    ];
  }
}

class NotificationData extends Equatable {
  final String title;
  final String message;
  // final String additionalData;
  final String remoteNotificationId;

  const NotificationData({
    required this.title,
    required this.message,
    required this.remoteNotificationId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'remoteNotificationId': remoteNotificationId,
    };
  }

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      remoteNotificationId: map['remoteNotificationId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationData.fromJson(String source) =>
      NotificationData.fromMap(json.decode(source));

  @override
  List<Object> get props => [title, message, remoteNotificationId];
}

final mockNotification = NotificationData.fromMap(const {
  "id": "be6a43b3-33e1-4d0d-a1de-04d0ae695dad",
  "type": "App\\Notifications\\AppNotification",
  "notifiable_type": "App\\Models\\User",
  "notifiable_id": "98194b5c-f488-4a69-972f-179c2b7bff41",
  "data": {
    "title": "test",
    "message": "test",
    "additionalData": "{\"type\":\"Event notification\"}",
    "remoteNotificationId": "8e0ff8fd-cabe-4832-9728-777c95b5fb38"
  },
  "read_at": null,
  "created_at": "2023-03-06T11:56:16.000000Z",
  "updated_at": "2023-03-06T11:56:16.000000Z"
});
