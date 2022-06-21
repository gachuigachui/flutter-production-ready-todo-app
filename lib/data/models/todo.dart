import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String? content;
  String? id;
  bool? isDone;
  Todo({
    this.content,
    this.id,
    this.isDone,
  });

  Todo.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    content = (snapshot.data() as Map<String, dynamic>)['content'];
    id = snapshot.id;
    isDone = (snapshot.data() as Map<String, dynamic>)['isDone'] as bool;
  }
}
