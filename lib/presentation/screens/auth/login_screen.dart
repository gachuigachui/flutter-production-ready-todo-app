import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:accountant_pro/presentation/widgets/base_screen.dart';
import 'package:accountant_pro/services/authentication.dart';

class LoginScreen extends StatelessWidget {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  LoginScreen({
    Key? key,
    required this.auth,
    required this.firestore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordlController = TextEditingController();
    return BaseScreen(
        body: Column(
      children: [
        const Center(
          child: Text("Login"),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _emailController,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordlController,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () async {
              var retVal = Auth(auth: auth).signIn(
                  email: _emailController.text.trim(),
                  password: _passwordlController.text);
            },
            child: const Text("Sign In"))
      ],
    ));
  }
}
