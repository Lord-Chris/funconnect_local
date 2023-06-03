import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginOptionsModel extends Equatable {
  final String id;
  final String userId;
  final LoginOptionsData data;

  const LoginOptionsModel({
    required this.id,
    required this.userId,
    required this.data,
  });

  const LoginOptionsModel.initial({
    this.id = '',
    this.userId = '',
    this.data = const LoginOptionsData.initial(),
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'data': data.toMap(),
    };
  }

  factory LoginOptionsModel.fromMap(Map<String, dynamic> map) {
    return LoginOptionsModel(
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      data: LoginOptionsData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginOptionsModel.fromJson(String source) =>
      LoginOptionsModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [id, userId, data];
}

class LoginOptionsData extends Equatable {
  final bool authWithGoogle;
  final bool authWithApple;

  const LoginOptionsData({
    required this.authWithGoogle,
    required this.authWithApple,
  });

  const LoginOptionsData.initial({
    this.authWithApple = false,
    this.authWithGoogle = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'auth_with_google': authWithGoogle,
      'auth_with_apple': authWithApple,
    };
  }

  factory LoginOptionsData.fromMap(Map<String, dynamic> map) {
    return LoginOptionsData(
      authWithGoogle: map['auth_with_google'] ?? false,
      authWithApple: map['auth_with_apple'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginOptionsData.fromJson(String source) =>
      LoginOptionsData.fromMap(json.decode(source));

  LoginOptionsData copyWith({
    bool? authWithGoogle,
    bool? authWithApple,
  }) {
    return LoginOptionsData(
      authWithGoogle: authWithGoogle ?? this.authWithGoogle,
      authWithApple: authWithApple ?? this.authWithApple,
    );
  }

  @override
  List<Object> get props => [authWithGoogle, authWithApple];
}

final mockLoginOptionsModel = LoginOptionsModel.fromMap(const {
  "id": "99522a22-723c-4cec-887d-58c72dcb783b",
  "user_id": "98194b5c-f488-4a69-972f-179c2b7bff41",
  "data": {"auth_with_google": true, "auth_with_apple": true}
});
