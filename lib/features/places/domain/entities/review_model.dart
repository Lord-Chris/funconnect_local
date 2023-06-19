// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String id;
  final String placeId;
  final String userId;
  final int rating;
  final String title;
  final String comment;
  final int vote;
  final DateTime? reviewedAt;
  final String? reviewedBy;
  final String status;
  final DateTime? deletedAt;
  final UserPublicModel? user;

  const ReviewModel({
    required this.id,
    required this.placeId,
    required this.userId,
    required this.rating,
    required this.title,
    required this.comment,
    required this.vote,
    this.reviewedAt,
    this.reviewedBy,
    required this.status,
    this.deletedAt,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place_id': placeId,
      'user_id': userId,
      'rating': rating,
      'title': title,
      'comment': comment,
      'vote': vote,
      'reviewed_at': reviewedAt?.toIso8601String(),
      'reviewed_by': reviewedBy,
      'status': status,
      'deleted_at': deletedAt?.toIso8601String(),
      'user': user?.toMap() ?? ''
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] ?? '',
      placeId: map['place_id'] ?? '',
      userId: map['user_id'] ?? '',
      rating: map['rating']?.toInt() ?? 0,
      title: map['title'] ?? '',
      comment: map['comment'] ?? '',
      vote: map['vote']?.toInt() ?? 0,
      reviewedAt: map['reviewed_at'] != null
          ? DateTime.parse(map['reviewed_at'])
          : null,
      reviewedBy: map['reviewed_by'],
      status: map['status'] ?? '',
      deletedAt:
          map['deleted_at'] != null ? DateTime.parse(map['deleted_at']) : null,
      user: map['user'] != null ? UserPublicModel.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      id,
      placeId,
      userId,
      rating,
      title,
      comment,
      vote,
      status,
    ];
  }
}

class UserPublicModel extends Equatable {
  final String name;
  final String username;
  final String photoUrl;
  const UserPublicModel({
    required this.name,
    required this.username,
    required this.photoUrl,
  });

  UserPublicModel copyWith({
    String? name,
    String? username,
    String? photoUrl,
  }) {
    return UserPublicModel(
      name: name ?? this.name,
      username: username ?? this.username,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'username': username,
      'photo_url': photoUrl,
    };
  }

  factory UserPublicModel.fromMap(Map<String, dynamic> map) {
    return UserPublicModel(
      name: map['name'] as String,
      username: map['username'] as String,
      photoUrl: map['photo_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPublicModel.fromJson(String source) =>
      UserPublicModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, username, photoUrl];
}

final mockReview = ReviewModel.fromMap(const {
  "id": "98752e5f-a7c0-408d-995f-8f71006494dc",
  "place_id": "9871d5d7-122c-464a-8dd2-41bbd701d127",
  "user_id": "98194b5c-f488-4a69-972f-179c2b7bff41",
  "rating": 4,
  "title": "A good Review",
  "comment": "This should be a cool place normally and it is",
  "vote": 0,
  "reviewed_at": null,
  "reviewed_by": null,
  "status": "pending",
  "deleted_at": null
});

class ReviewParam {
  final String title;
  final String comment;
  final int rating;

  ReviewParam({
    required this.title,
    required this.comment,
    required this.rating,
  });

  Map<String, dynamic> toBody() {
    return {
      'title': "Not sooo big",
      'comment': comment,
      'rating': rating,
    };
  }
}
