import 'package:firebase_bloc/app.dart';
import 'package:firebase_bloc/src/data/repositories/firebase_user_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(FirebaseUserRepo()));
}

