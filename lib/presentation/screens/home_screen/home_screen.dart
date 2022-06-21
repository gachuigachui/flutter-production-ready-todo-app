import 'package:accountant_pro/presentation/widgets/base_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required FirebaseAuth auth, required FirebaseFirestore firestore});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          Text("ToDos"),
        ]))
      ],
    );
  }
}
