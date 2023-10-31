part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {}
class SignInFailure extends SignInState {
  final String? message;

  SignInFailure({this.message});
}

class SignInProcess extends SignInState {}
