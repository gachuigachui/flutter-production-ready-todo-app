import 'package:super_do/presentation/screens/auth/login_screen.dart';
import 'package:super_do/services/authentication.dart';
import 'package:super_do/utils/app_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:super_do/presentation/widgets/base_screen.dart';

class SignUpScreen extends StatelessWidget {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  SignUpScreen({
    Key? key,
    required this.auth,
    required this.firestore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordlController = TextEditingController();
    emailController.text = "test@gmail.com";
    passwordlController.text = "password";
    return BaseScreen(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Create Account",
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
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () async {
                final String retVal = await Auth(auth: auth).createAccount(
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
                  Text("Sign Up"),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Not implemented.")));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Sign With Google"),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen(
                                  auth: auth,
                                  firestore: firestore,
                                )));
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          ),
        ],
      ),
    ));
  }
}
