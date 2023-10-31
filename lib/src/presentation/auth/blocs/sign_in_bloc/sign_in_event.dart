part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInRequired extends SignInEvent {
  final String email;
  final String password;

  SignInRequired(this.email, this.password);
}

class SignOutRequired extends SignInEvent {

  SignOutRequired();
}