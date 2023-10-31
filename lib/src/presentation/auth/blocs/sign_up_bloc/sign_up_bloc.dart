import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_bloc/src/data/models/models.dart';
import 'package:firebase_bloc/src/domain/repositories/user_repo.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({
    required userRepository,
  }) : _userRepository = userRepository,
    super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        MyUser myUser = await _userRepository.signUp(event.myUser, event.password);
        await _userRepository.setUserData(myUser);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }
}
