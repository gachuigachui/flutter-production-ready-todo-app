import 'package:accountant_pro/data/models/todo.dart';
import 'package:accountant_pro/services/authentication.dart';
import 'package:accountant_pro/services/database.dart';
import 'package:accountant_pro/utils/app_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:accountant_pro/presentation/widgets/base_screen.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const HomeScreen({super.key, required this.auth, required this.firestore});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState(firestore: firestore, auth: auth);
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  _HomeScreenState({required this.auth, required this.firestore});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBar: AppBar(title: Text("To Do app")), body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    TextEditingController _contentController = TextEditingController();
    return Column(
      children: [
        Container(
            height: 180,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "ToDos",
                    style: AppStyles.whiteHugeTextBold30,
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _contentController,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (_contentController.text != "") {
                                setState(() {
                                  Database(firestore: firestore).addTodo(
                                      _contentController.text,
                                      auth.currentUser!.uid);
                                });
                              }
                            },
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                ),
              ],
            )),
        StreamBuilder(
          stream:
              Database(firestore: firestore).streamTodos(auth.currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data?.length == 0) {
                return Text("You have no To Dos");
              }
            }
            return snapshot != null && snapshot.data != null
                ? Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snapshot.data![index].content!),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Database(firestore: firestore)
                                            .deleteTodo(
                                          uid: auth.currentUser!.uid,
                                          todoId: snapshot.data![index].id!,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("Deleted")));
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                    Checkbox(
                                      value:
                                          snapshot.data![index].isDone as bool,
                                      onChanged: (value) {
                                        Database(firestore: firestore)
                                            .updateTodo(
                                                auth.currentUser!.uid,
                                                snapshot.data![index].id!,
                                                value!);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("$value")));
                                      },
                                    ),
                                  ],
                                ),
                              ]),
                        );
                      },
                    ),
                  )
                : Center(child: Text("There was an error"));
          },
        ),
      ],
    );
  }
}
