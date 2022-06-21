import 'package:super_do/presentation/screens/auth/signup_screen.dart';
import 'package:super_do/utils/app_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:super_do/presentation/widgets/base_screen.dart';
import 'package:super_do/services/authentication.dart';

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
    TextEditingController emailController = TextEditingController();
    emailController.text = "test@gmail.com";
    TextEditingController passwordlController = TextEditingController();
    passwordlController.text = "password";
    return BaseScreen(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Login",
              style: AppStyles.whiteHugeTextBold30,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: emailController,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: passwordlController,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () async {
                var retVal = await Auth(auth: auth).signIn(
                    email: emailController.text.trim(),
                    password: passwordlController.text);
                if (retVal == "Success") {
                  emailController.clear();
                  passwordlController.clear();
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(retVal)));
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.security,
                    size: 14,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Sign In"),
                ],
              )),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen(
                                  auth: auth,
                                  firestore: firestore,
                                )));
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          ),
        ],
      ),
    ));
  }
}
