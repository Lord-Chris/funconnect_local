import 'package:equatable/equatable.dart';

class EmailSignInParams extends Equatable {
  final String email;

  const EmailSignInParams({
    required this.email,
  });

  @override
  List<Object?> get props => [email];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }
}
