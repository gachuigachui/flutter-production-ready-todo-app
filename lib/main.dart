import 'package:accountant_pro/firebase_options.dart';
import 'package:accountant_pro/presentation/router/my_router.dart';
import 'package:accountant_pro/presentation/screens/auth/login_screen.dart';
import 'package:accountant_pro/presentation/screens/home_screen/home_screen.dart';
import 'package:accountant_pro/presentation/screens/show_error_screen.dart';
import 'package:accountant_pro/presentation/widgets/base_screen.dart';
import 'package:accountant_pro/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return const ShowErrorScreen();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Accountant Pro',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            onGenerateRoute: MyRouter().onGenerateRoute,
          );
        }

        return const Loading();
      }),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(body: Center(child: CircularProgressIndicator()));
  }
}

class Root extends StatefulWidget {
  const Root({super.key, required this.title});
  final String title;

  @override
  State<Root> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Root> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth(auth: _auth).user,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data?.uid == null) {
            return  LoginScreen(auth: _auth, firestore:_firestore);
          } else {
            return  HomeScreen(auth: _auth, firestore:_firestore);
          }
        } else {
          return const Loading();
        }
      },
    );
  }

  Scaffold buildView() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Use this app to manage your errands and stay up with deadlines',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
