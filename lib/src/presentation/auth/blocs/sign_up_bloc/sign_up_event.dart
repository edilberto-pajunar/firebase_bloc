part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpRequired extends SignUpEvent {
  final MyUser myUser;
  final String password;

  SignUpRequired(this.myUser, this.password);
}
