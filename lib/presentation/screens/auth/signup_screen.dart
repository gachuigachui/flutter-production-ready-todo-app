import 'package:accountant_pro/presentation/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
        body: Center(
      child: Text("SignUp"),
    ));
  }
}
