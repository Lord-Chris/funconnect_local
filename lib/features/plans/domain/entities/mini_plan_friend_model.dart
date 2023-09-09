import 'dart:convert';

class MiniPlanFriend {
  String email;
  String miniPlanId;
  String id;
  MiniPlanFriend({
    required this.email,
    required this.miniPlanId,
    required this.id,
  });

  MiniPlanFriend copyWith({
    String? email,
    String? miniPlanId,
    String? id,
  }) {
    return MiniPlanFriend(
      email: email ?? this.email,
      miniPlanId: miniPlanId ?? this.miniPlanId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'mini_plan_id': miniPlanId});
    result.addAll({'id': id});

    return result;
  }

  factory MiniPlanFriend.fromMap(Map<String, dynamic> map) {
    return MiniPlanFriend(
      email: map['email'] ?? '',
      miniPlanId: map['mini_plan_id'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MiniPlanFriend.fromJson(String source) =>
      MiniPlanFriend.fromMap(json.decode(source));

  @override
  String toString() =>
      'MiniPlanFriend(email: $email, miniPlanId: $miniPlanId, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MiniPlanFriend &&
        other.email == email &&
        other.miniPlanId == miniPlanId &&
        other.id == id;
  }

  @override
  int get hashCode => email.hashCode ^ miniPlanId.hashCode ^ id.hashCode;
}
