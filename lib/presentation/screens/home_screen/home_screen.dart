import 'package:super_do/data/models/todo.dart';
import 'package:super_do/services/database.dart';
import 'package:super_do/utils/app_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:super_do/presentation/widgets/base_screen.dart';

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
        appBar: AppBar(
          title: const Text("To Do app"),
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut();
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    TextEditingController contentController = TextEditingController();
    return Column(
      children: [
        Container(
            height: 180,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "ToDos",
                    style: AppStyles.whiteHugeTextBold30,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: contentController,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (contentController.text != "") {
                                setState(() {
                                  Database(firestore: firestore).addTodo(
                                      contentController.text,
                                      auth.currentUser!.uid);
                                });
                              }
                            },
                            icon: const Icon(Icons.add)),
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
                return const Text("You have no unfinished ToDos");
              }
            }
            return snapshot.data != null
                ? Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(snapshot.data![index].content!),
                                ),
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
                                            .showSnackBar(const SnackBar(
                                                content: Text("Deleted")));
                                      },
                                      icon: const Icon(Icons.delete),
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
                : const Center(child: Text("There was an error"));
          },
        ),
      ],
    );
  }
}
