import 'package:equatable/equatable.dart';

abstract class EmailSignInEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailFieldChangeEvent extends EmailSignInEvent {}

class GetCodeEvent extends EmailSignInEvent {}

class SignInWithEmail extends EmailSignInEvent {
  final String email;

  SignInWithEmail({
    required this.email,
  });
}
