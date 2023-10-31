import 'package:firebase_bloc/app_view.dart';
import 'package:firebase_bloc/src/domain/repositories/user_repo.dart';
import 'package:firebase_bloc/src/presentation/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp(this.userRepository, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc(userRepository: userRepository))
      ],
      child: const MyAppView(),
    );
  }
}
