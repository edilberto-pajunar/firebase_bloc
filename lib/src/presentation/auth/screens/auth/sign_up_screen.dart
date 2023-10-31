import 'package:firebase_bloc/src/data/models/models.dart';
import 'package:firebase_bloc/src/presentation/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:firebase_bloc/src/presentation/auth/screens/auth/components/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signUpRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$');
    final RegExp passwordRegExp = RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$');
    final ThemeData theme = Theme.of(context);

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
          // Navigator.pop(context);
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          return;
        }
      },
      child: Form(
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
            const SizedBox(height: 10.0),
            SizedBox(
              width: size.width * 0.9,
              child: MyTextField(
                controller: nameController,
                hintText: "Name",
                obscureText: false,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(CupertinoIcons.profile_circled),
                errorMsg: _errorMsg,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please fill in this field";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20.0),
            !signUpRequired
                ? SizedBox(
              width: size.width * 0.5,
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    MyUser myUser = MyUser.empty;
                    myUser = myUser.copyWith(
                      email: emailController.text,
                      name: nameController.text,
                    );
                    setState(() {
                      context.read<SignUpBloc>().add(SignUpRequired(
                        myUser,
                        passwordController.text,
                      ));
                    });
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
                  padding: EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 8.0),
                  child: Text("Sign up",
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
      ),
    );
  }
}
