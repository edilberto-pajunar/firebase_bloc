import 'package:firebase_bloc/src/presentation/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:firebase_bloc/src/presentation/auth/screens/auth/components/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$');
    final RegExp passwordRegExp = RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$');
    final ThemeData theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          SizedBox(
            width: size.width * 0.9,
            child: MyTextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(CupertinoIcons.mail_solid),
              errorMsg: _errorMsg,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please fill in this field";
                } else if (!emailRegExp.hasMatch(value)) {
                  return "Please enter a valid email";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: size.width * 0.9,
            child: MyTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: obscurePassword,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: const Icon(CupertinoIcons.lock_fill),
              errorMsg: _errorMsg,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                  if (obscurePassword) {
                    iconPassword = CupertinoIcons.eye_fill;
                  } else {
                    iconPassword = CupertinoIcons.eye_slash_fill;
                  }
                },
                icon: Icon(iconPassword),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please fill in this field";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20.0),
          !signInRequired
            ? SizedBox(
            width: size.width * 0.5,
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SignInBloc>().add(SignInRequired(
                    emailController.text,
                    passwordController.text,
                  ));
                }
              },
              style: TextButton.styleFrom(
                elevation: 3.0,
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
                child: Text("Sign in",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ) : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
